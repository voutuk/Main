
import { jwtDecode } from "jwt-decode";
import { IUser } from "../models/account";
export const jwtParse = (token: string): IUser | null => {
  try {
    const data = jwtDecode<any>(token);
    return {
      id: data['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      exp: data['exp'],
      photo: data['photo'],
      roles: data['roles'] || [],
      phone:data['phoneNumber']
    }
  }
  catch (error) {
    console.log("Помилка при парсингу токена:", error);
    return null;
  }
}