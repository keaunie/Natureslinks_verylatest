import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:natureslink/dbHelper/mongodb.dart';
import 'globals.dart' as globals;

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  var newPassController = new TextEditingController();
  var new2PassController = new TextEditingController();
  var oldPassController = new TextEditingController();

  bool _isHidden1 = true;
  bool _isHidden2 = true;


  Future<void> getInfoToChange()async{
    var allUserInfos = await MongoDatabase.userCollection.find({'_id': globals.uid}).toList();
    final List<dynamic> dataList = allUserInfos;
    final item = dataList[0];
    globals.oldpass = item['pass'];
    globals.newpass = newPassController.text;

    var salt = await BCrypt.gensalt(logRounds: 10);
    var hashedPassword = await BCrypt.hashpw(newPassController.text, salt);

    bool checkpassword = await BCrypt.checkpw(newPassController.text, item['pass']);





    print(globals.oldpass);
    if(checkpassword){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("You cannot use your old password")));
    }else{
      MongoDatabase.userCollection.updateOne(M.where.eq('_id', globals.uid), M.modify.set('pass', hashedPassword));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Change Password Success")));
      Navigator.pop(context);
    }


  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration:
        const BoxDecoration(image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 2, child: Container(color: Colors.greenAccent.withOpacity(0.5))),
                Expanded(child: Container(color: Colors.green.withOpacity(0.7))),
              ],
            ),
            Align(
              alignment: Alignment(0, 0.5),
              child: Container(
                width: size.width * 0.90,
                height: size.height * 0.75,
                child: Column(
                  children: [
                    Text('Change Password',
                        style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Card(
                      elevation: 12,
                      child: Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Center(
                            child: Column(
                          children: [
                            TextField(
                              controller: oldPassController,
                              obscureText: _isHidden1,
                              decoration: InputDecoration(
                                hintText: 'Old Password',
                                suffix: InkWell(
                                  onTap: _togglePasswordView1,
                                  child: Icon(
                                    _isHidden1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              controller: newPassController,
                              obscureText: _isHidden2,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                suffix: InkWell(
                                  onTap: _togglePasswordView2,
                                  child: Icon(
                                    _isHidden2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        if(newPassController.text.length < 8){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Your new password must be longer than 8 characters")));
                        }else{
                          if (oldPassController.text.isEmpty || newPassController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("Please Insert Data")));
                          } else {
                            getInfoToChange();
                          }
                        }


                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }

  void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }
}
