import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker18/components/my_drawer.dart';
import 'package:habit_tracker18/components/my_habit_tile.dart';
import 'package:habit_tracker18/components/my_heat_map.dart';
import 'package:habit_tracker18/database/habit_database.dart';
import 'package:habit_tracker18/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../models/habit.dart';
import '../util/habit_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    //read existing habit on app startup
    Provider.of<HabitDatabase>(context , listen:  false).readHabits();
    super.initState();

  }
  //textController
  final TextEditingController textController = TextEditingController();

  //create new Habit
  void createNewHabit(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Create a new habit"
            ),
          ),
          actions: [
            //save button
            MaterialButton(onPressed: (){
              //get the new habit name
              String newHabitName = textController.text;

              // save to db
              context.read<HabitDatabase>().addHabit(newHabitName);

              //pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
              child: Text('Save'),
            ),
            //cancel button
            MaterialButton(onPressed: (){
              //pop box
              Navigator.pop(context);

              //clear controller
              textController.clear();
            },
            child:Text("Cancel") ,
            )
          ],
        ),
    );
  }

  //check habit on & off
  void checkHabitOnOff(bool?value , Habit habit){
    // update habit completion status
    if(value !=null){
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  //edit habit box
  void editHabitBox(Habit habit){
    // set the controller's text to the habit's current name
    textController.text = habit.name;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            //save button
            MaterialButton(onPressed: (){
              //get the new habit name
              String newHabitName = textController.text;

              // save to db
              context.read<HabitDatabase>().updatedHabitName(habit.id,newHabitName);

              //pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
              child: Text('Save'),
            ),
            //cancel button
            MaterialButton(onPressed: (){
              //pop box
              Navigator.pop(context);

              //clear controller
              textController.clear();
            },
              child:Text("Cancel") ,
            )
          ],
        ),
    );
  }

  // delete habit box
  void deleteHabitBox(Habit habit){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure want to delete?"),
        actions: [
          //delete button
          MaterialButton(onPressed: (){

            // save to db
            context.read<HabitDatabase>().deleteHabit(habit.id);

            //pop box
            Navigator.pop(context);


          },
            child: Text('Delete'),
          ),
          //cancel button
          MaterialButton(onPressed: (){
            //pop box
            Navigator.pop(context);

          },
            child:Text("Cancel") ,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(Icons.add , color: Colors.black,),
      ),
      body: ListView(
        children: [
          // HEAT MAP
          _buildHeatMap(),

          //HEABIT LIST
          _buildHabitList(),
        ],
      ),
    );
  }
  Widget _buildHeatMap(){
    // habit database
    final habitDatabase = context.watch<HabitDatabase>();

    // current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    //return heat map UI

    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        // once the data is available -> build heatmap
        if(snapshot.hasData){
          return MyHeatMap(
              startDate: snapshot.data!,
              datasets: prepHeatMapDataset(currentHabits),
          );
        }
        else{
          return Container();
        }

        // handle case where no data is returned
      },
    );
  }

  Widget _buildHabitList(){
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit> currentHabits =habitDatabase.currentHabits;

    //return List of habits UI
    return ListView.builder(
        itemCount: currentHabits.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          //get each individual habit
          final habit = currentHabits[index];

          //check if the habit is completed today
          bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

          //return habit tile UI
          return MyHabitTile(
              text: habit.name,
              isCompleted: isCompletedToday,
              onChanged: (value) => checkHabitOnOff(value , habit),
              editHabit: (context) => editHabitBox(habit),
              deleteHabit: (context) => deleteHabitBox(habit),

          );
        },
    );
  }
}
