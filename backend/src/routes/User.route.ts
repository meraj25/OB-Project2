import express from "express"
import { getallUsers,getuserbyId,registerUser,Login,Logout,updateUserbyId,getuser,Refresh } from "../controllers/User.controller"
import { validateToken } from "../middleware/JWT";

const UserRouter = express.Router();

    UserRouter
      .route("/")
      .get(getallUsers)


    UserRouter
      .route("/register")
      .post(registerUser)
      
    UserRouter
      .route("/login")
      .post(Login)

     UserRouter
      .route("/refresh")
      .post(Refresh)

    UserRouter
      .route("/logout")
      .post(validateToken,Logout)

    UserRouter
      .route("/getuser")
      .get(validateToken,getuser)


    UserRouter
      .route("/:id")
      .get(validateToken,getuserbyId)
      .patch(validateToken,updateUserbyId)


      export default UserRouter;
    