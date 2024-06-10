//!
//!THIS FILE HOUSES SIMPLE MODELS OF DATA TYPES THAT WE REQUEST FROM OR RETURN TO THE CLIENT
//!
//!

//!
//! SYSTEM USER MODEL
export interface User {
  id: string;
  name: string;
  email: string;
  profilePic: string;
}

//!
//! MODEL OF DATA RETURNED TO THE CLIENT
export interface UserAndCredentials {
  user: User;
  token: string;
  refresh: string;
}

//!
//! GET USER DATA RETURN PARAMS
export interface GetUserDataReturnParams {
  user: User;
}

//!
//! LOGIN PARAMS
export interface LoginParams {
  email: string;
  name: string;
  profilePic: string;
}

//!
//! LOGIN PARAMS
export interface GetUserDataParams {
  token: string;
}

//!
//! REFRESH PARAMS
export interface RefreshParams {
  email: string;
  refreshToken: string;
}
