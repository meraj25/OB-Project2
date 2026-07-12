    import { createUser,login } from "../services/User.service";
    import {create,findUsersByName} from "../repositories/User.repository"
    import ValidationError from "../domain/errors/validation-error";
    import NotFoundError from "../domain/errors/not-found-error";
    import bcrypt from "bcrypt"


    jest.mock("../repositories/User.repository", () => ({
    create: jest.fn(),
    findUsersByName: jest.fn(),
    }));

    describe("createUser" ,() =>{

        it("throws an error when password is missing ", async () => {
            await expect(
                createUser({name: "yasas" })
            ).rejects.toThrow(ValidationError)
        });

        it("throws an error when the username is already taken", async () => {
            
            (findUsersByName as jest.Mock).mockResolvedValue([
                {id:1 , name:"yasas"},
            ]);

            await expect(
                createUser({name:"yasas",password:"yasas123"})
                
            ).rejects.toEqual({
                status:409,
                message: " User name is already taken, try a new one!"
            })

        })


    })

    describe("login", () => {

        it("throws an error when username and password do not exist", async () => {
            (findUsersByName as jest.Mock).mockResolvedValue([]);

            await expect(

                login({ name:"yasas", password:"yasas123"})
            ).rejects.toThrow(NotFoundError);
        });

        it("throws ValidationError when name or password is missing", async () => {
        await expect(
        login({ name: "", password: "" } as any)
        ).rejects.toThrow(ValidationError);
        });

        it("throws an error when the password is wrong", async () => {
        const hashedPassword = await bcrypt.hash("yasas@123", 10);

        (findUsersByName as jest.Mock).mockResolvedValue([{
        id: "1",
        name: "yasas",    
        password: hashedPassword,
        }]);

        await expect(
        login({ name: "yasas", password: "yasas1" })
        ).rejects.toThrow(ValidationError);
    });

    })