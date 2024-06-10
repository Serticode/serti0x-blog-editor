//!
//!THIS IS SIMPLY THE REPOSITORY THAT DOES THE MAIN FUNCTIONS.
//! ALL FUNCTIONS IN HERE ARE CALLED BY THE CONTROLLERS
//!
import jwt from "jsonwebtoken";
import { v4 as uuidv4 } from "uuid";
import Blacklist from "../../database/models/blacklist/blacklist_tokens";
import User from "../../database/models/user/user_model";
import {
  BadRequestError,
  UnauthorizedError,
  UserProfileNotFoundError,
} from "../../errors";
import AuthenticatedUser from "../../middleware/models/authenticated_user";
import {
  GetUserDataReturnParams,
  LoginParams,
  RefreshParams,
  UserAndCredentials,
} from "../models/auth_models";

export default class AuthService {
  //!
  //! LOGIN
  public async login(params: LoginParams): Promise<UserAndCredentials> {
    //! GET USER DETAILS FROM PARAMS AND FIND USER IN DB.
    let user = await User.findOne({ email: params.email });

    //! USER IS NOT FOUND, CREATE USER
    if (!user) {
      user = new User({
        name: params.name,
        email: params.email,
        profilePic: params.profilePic,
      });

      await User.create(params);
    }

    //! SINCE WE ARE NOT USING PASSWORDS GENERATE TOKEN DIRECTLY AS USER HAS BEEN SIGNED IN
    //! USING OAUTH - GOOGLE SIGN IN.
    const uuid = uuidv4();
    const token = user.createJWT(uuid);
    const refresh = user.createRefresh(uuid);

    return {
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        profilePic: user.profilePic,
      },
      token,
      refresh,
    };
  }

  //!
  //!
  public async getUserData(userID: string): Promise<GetUserDataReturnParams> {
    let user = await User.findOne({ _id: userID });

    if (!user) {
      throw new UserProfileNotFoundError();
    }

    return {
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        profilePic: user.profilePic,
      },
    };
  }

  //!
  //! LOG OUT
  public async logout(jti: string): Promise<void> {
    await Blacklist.create({ object: jti, kind: "jti" });
  }

  //!
  //! REFRESH TOKEN
  public async refresh(
    params: RefreshParams,
    user: AuthenticatedUser
  ): Promise<UserAndCredentials> {
    const decodedRefreshToken = jwt.verify(
      params.refreshToken,
      process.env.REFRESH_SECRET
    ) as {
      userId: string;
      email: string;
      iss: string;
      jti: string;
    };

    if (
      decodedRefreshToken.email === user.email &&
      decodedRefreshToken.iss === process.env.JWT_ISSUER &&
      decodedRefreshToken.userId == user.id &&
      decodedRefreshToken.email === user.email &&
      decodedRefreshToken.iss === user.iss &&
      decodedRefreshToken.jti === user.jti
    ) {
      //! MAKE SURE THE TOKEN ISN'T BLACKLISTED
      const blacklisted = await Blacklist.findOne({
        object: decodedRefreshToken.jti,
        kind: "jti",
      });
      if (blacklisted) {
        throw new UnauthorizedError();
      }

      //! BLACK LIST THE GIVEN REFRESH TOKEN
      await Blacklist.create({ object: decodedRefreshToken.jti });

      const user = await User.findById(decodedRefreshToken.userId);

      if (!user) {
        throw new BadRequestError();
      }

      const uuid = uuidv4();
      const newToken = user.createJWT(uuid);
      const newRefresh = user.createRefresh(uuid);

      return {
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          profilePic: user.profilePic,
        },
        token: newToken,
        refresh: newRefresh,
      };
    } else {
      throw new UnauthorizedError();
    }
  }

  //! END OF FILE
}
