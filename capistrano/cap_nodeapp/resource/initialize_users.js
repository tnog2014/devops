// ユーザーが存在しない場合には、デフォルト管理ユーザーを追加する。
print("ユーザーが存在しない場合、デフォルト管理ユーザーを追加する。");
var users = db.users.find();
var count = users.count();
print("登録ユーザー数:" + count);
if(count == 0){
  var user = {
    username: "admin",
    password: "0dd82fec2ce8809d3a73c0c995529053a5d406e2d127018ac7a9c84e583b9e0c", // nodeapp123
    surname: "Admin",
    firstname: "Admin",
    role: "admin"
  }
  db.users.save(user);
  print("ユーザーが存在しないため、デフォルト管理ユーザーを登録しました。");
} else {
  print("ユーザーが存在するため、デフォルト管理ユーザーの追加を行いません。");
}
