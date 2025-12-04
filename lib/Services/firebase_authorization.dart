import 'package:firebase_auth/firebase_auth.dart';

Future<String?> signUp(String name, String email, String password) async
{
    try
    {
        UserCredential userCred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        User? user = userCred.user;

        if (user == null) return "SomethingWentWrong";

        await user.sendEmailVerification();

        await FirebaseAuth.instance.signOut();
        return "emailSent";
    }
    on FirebaseAuthException catch (e)
    {
        return e.code;
    }
}


Future<String?> logIn(String email, String password) async
{
    try
    {
        UserCredential userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        );
        User? user = userCred.user;

        if (user == null) return "Something went wrong";

        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user!.emailVerified)
        {
            return "success";
        }
        else 
        {
            await user.sendEmailVerification();
            await FirebaseAuth.instance.signOut();
            return "notVerified";
        }

    }
    on FirebaseAuthException catch (e)
    {
        return e.code;
    }
}

Future<String?> forgetPassword(String email) async
{
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return "success";
  } on FirebaseAuthException catch(e){
    return e.code;
  }
}
