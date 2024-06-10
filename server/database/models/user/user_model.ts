import jwt from "jsonwebtoken";
import { Document, model, Schema } from "mongoose";

//!
//! INITIAL SCHEMA / PAYLOAD OR DATA STRUCTURE FOR OUR AUTHORIZED USER
//! AS IT SHOULD BE STORED ON THE BE
const UserSchema = new Schema({
  name: {
    type: String,
    required: [true, "Please enter your name"],
    trim: true,
    maxlength: [30, "Your name cannot exceed 30 characters"],
    minlength: [3, "Your name must be at least 3 characters long"],
  },
  email: {
    type: String,
    required: [true, "Please enter your email"],
    trim: true,
    unique: true,
    match: [
      /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
      "Please provide a valid email",
    ],
  },
  profilePic: {
    type: String,
    required: true,
  },
});

//!
//! CREATING JWT
UserSchema.methods.createJWT = function (uuid: string): string {
  const token = jwt.sign(
    { userId: this._id, email: this.email },
    process.env.JWT_SECRET,
    {
      expiresIn: process.env.JWT_EXPIRES,
      issuer: process.env.JWT_ISSUER,
      jwtid: uuid,
    }
  );
  return token;
};

//!
//! CREATING REFRESH TOKENS
UserSchema.methods.createRefresh = function (uuid: string): string {
  const refreshToken = jwt.sign(
    { userId: this._id, email: this.email },
    process.env.REFRESH_SECRET,
    {
      expiresIn: process.env.REFRESH_EXPIRES,
      issuer: process.env.JWT_ISSUER,
      jwtid: uuid,
    }
  );
  return refreshToken;
};

//!
//! USER SCHEMA TO JSON
UserSchema.methods.toJSON = function (): any {
  return {
    id: this._id,
    name: this.name,
    email: this.email,
    profilePic: this.profilePic,
  };
};

//!
//! CREATING MONGOOSE - MONGODB DOCUMENT
//! ACTUAL SCHEMA
export interface UserDocument extends Document {
  name: string;
  email: string;
  profilePic: string;
  createJWT: (uuid: string) => string;
  createRefresh: (uuid: string) => string;

  toJSON: () => any;
}

export default model<UserDocument>("User", UserSchema);
