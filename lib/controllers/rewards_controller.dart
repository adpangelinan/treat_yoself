import 'package:treat_yoself/controllers/controllers.dart';
import '../utils/database/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../utils/entities/reward.dart';
import '../utils/entities/shoppinglist.dart';
import '../utils/entities/shoppingitem.dart';
import '../controllers/auth_controller.dart';
import 'dart:convert';

class RewardsController extends GetxController {
  var rewards = List<Reward>().obs;
  Reward userRewards;
  @override
  void onInit() {
    _getData();

    super.onInit();
  }

  /* when controller is initialized, grabs all rewards*/
  void _getData() {
    print("fetching data");
    fetchAllRewards().then((value) {
      print("received data");
      print("$value");
      for (var i = 0; i < value.length; i++) {
        Reward newReward = new Reward(
            value[i][0].toString(), //rewardID
            value[i][1].toString(), //uid
            value[i][2].toString(), //fuid
            value[i][3].toString(), //usid
            value[i][4]); //points
        rewards.add(newReward);
      }
    });
  }

  //finds a user reward in the entire array with a specified fuid
  Reward getUserReward(String fuid) {
    for (var i = 0; i < rewards.length; i++) {
      //  print("comparing ${rewards[i].fuid} with $fuid");
      if (rewards[i].fuid == fuid) {
        return rewards[i];
      }
    }
    print("No reward found");

    return null;
  }

  void setUserReward(Reward r) {
    userRewards = r;
  }

  Reward getCurrentUser() {
    return userRewards;
  }

  //calculates level of current user based on number of points
  //Updates if new level achieved
  String calcLevel() {
    int p = userRewards.points;

    print("points is $p");
    for (int pointsThreshold in titles.keys) {
      if (p >= pointsThreshold) {
        return titles[pointsThreshold];
      }
    }
    if (p < 0) {
      return "err";
    }
  }

  //adds points to current user
  void addPoints(Reward r, int points) {
    //add to data structure
    r.points += points;
    //Update points in database
    setPoints(r.usid, r.points);
  }

  //if a user updates a list rewards points
  void userUpdatesList() {
    addPoints(userRewards, 15);
  }

  void userAddComment(){
    addPoints(userRewards, 5);
  }

  void resetPoints() {
    userRewards.points = 0;
    setPoints(userRewards.usid, 0);
  }

  //gets points for a specified user
  int getPoints() {
    return userRewards.points;
  }
}

//db queries
Future<List<dynamic>> fetchAllRewards() async {
  final dbEngine = new DatabaseEngine();
  var querySelect =
      "SELECT Rewards.RewardID as RID, Users.UserID as UID, Users.fuid as FUID,  UserStats.UserStatsID as USID, UserStats.Points as Points";
  var queryFrom = " FROM Users";
  var queryJoin1 =
      " LEFT JOIN UsersRewards ON Users.UserID = UsersRewards.UserID";
  var queryJoin2 =
      " LEFT JOIN Rewards ON UsersRewards.RewardID = Rewards.RewardID";
  var queryJoin3 =
      " LEFT JOIN UserStats ON Users.UserStatsID = UserStats.UserStatsID;";
  var query = querySelect + queryFrom + queryJoin1 + queryJoin2 + queryJoin3;

  var results = await dbEngine.manualQuery(query);

  return results;
}

Future setPoints(userStatsID, points) async {
  print("setting $userStatsID to $points");
  final dbEngine = new DatabaseEngine();
  var query = "UPDATE UserStats SET Points = ? WHERE UserStatsID = ?";
  await dbEngine.manualQuery(query, [points, userStatsID]);
}

//Map used to set point thresholds for titles (level)
Map<int, String> titles = {
  400: 'masterShopper',
  300: 'expertShopper',
  200: 'shopper',
  100: 'superNoob',
  0: 'noob'
};
