import 'package:flutter/material.dart';
import '../../models/user/query_likes_user.dart';
import '../../widgets/drawer.dart';
import '../user_list.dart';

class FilterUsersOthers extends StatelessWidget {
  final TextEditingController petController = TextEditingController();
  final TextEditingController introvertedController = TextEditingController();
  final TextEditingController cleaningController = TextEditingController();
  final TextEditingController vapeController = TextEditingController();
  final TextEditingController smokeController = TextEditingController();
  final TextEditingController workFromHomeController = TextEditingController();
  final TextEditingController sleepTimeController = TextEditingController();
  final TextEditingController externalPeopleController = TextEditingController();


  FilterUsersOthers({Key? key, required UserPreferencesDTO userPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          "Search Roommate",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(text: 'Location', onPressed: () {}),
                  const SizedBox(width: 10),
                  RoundedButton(text: 'Information', onPressed: () {}),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'You have any problem having pets at the house?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExclusiveCheckboxGroup(
                    labels: const ['Yes', 'No'],
                    controller: petController,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'You want your roomie to be introverted or extroverted?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExclusiveCheckboxGroup(
                    labels: const ['Introverted', 'Extroverted'],
                    controller: introvertedController,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'How often do you clean your house?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CleaningFrequencySlider(controller: cleaningController),
              const SizedBox(height: 16),
              const Text(
                'Do you Vape?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExclusiveCheckboxGroup(
                    labels: const ['Yes', 'No'],
                    controller: vapeController,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Do you smoke?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExclusiveCheckboxGroup(
                    labels: ['Yes', 'No'],
                    controller: smokeController,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Do you work from home?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExclusiveCheckboxGroup(
                    labels: ['Yes', 'No'],
                    controller: workFromHomeController,
                  ),
                ],
              ),
              const Text(
                'At what time do you go to sleep?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SleepHourFrequencySlider(controller: sleepTimeController),
              const Text(
                'How many times will you bring people a week?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FrequencyOfExternalPeople(
                controller: externalPeopleController,
              ),
              ElevatedButton(
                onPressed: () {
                  UserPreferencesDTO userPrefs = UserPreferencesDTO(

                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserList(userPreferences: userPrefs, title: '',),
                    ),
                  );
                },
                child: Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExclusiveCheckboxGroup extends StatefulWidget {
  final List<String> labels;
  final TextEditingController controller;

  ExclusiveCheckboxGroup({
    required this.labels,
    required this.controller,
  });

  @override
  _ExclusiveCheckboxGroupState createState() =>
      _ExclusiveCheckboxGroupState();
}

class _ExclusiveCheckboxGroupState extends State<ExclusiveCheckboxGroup> {
  String? _selectedLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.labels
          .map(
            (label) => ExclusiveCheckbox(
          label: label,
          isSelected: label == _selectedLabel,
          onSelect: () {
            setState(() {
              _selectedLabel = label;
              widget.controller.text = label;
            });
          },
        ),
      )
          .toList(),
    );
  }
}

class ExclusiveCheckbox extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  ExclusiveCheckbox({
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (value) {
            onSelect();
          },
        ),
        Text(label),
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  RoundedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF2c595b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }
}

class CleaningFrequencySlider extends StatefulWidget {
  final TextEditingController controller;

  CleaningFrequencySlider({required this.controller});

  @override
  _CleaningFrequencySliderState createState() =>
      _CleaningFrequencySliderState();
}

class _CleaningFrequencySliderState extends State<CleaningFrequencySlider> {
  int _value = 1; // Valor inicial

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayColor: Colors.white.withOpacity(0.4),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: _value.toDouble(),
        onChanged: (newValue) {
          setState(() {
            _value = newValue.round();
            widget.controller.text = _value.toString();
          });
        },
        min: 1,
        max: 3,
        divisions: 2,
        label: _value == 1
            ? 'Once a week'
            : _value == 2
            ? 'Twice a week'
            : 'Three times a week',
      ),
    );
  }
}

class SleepHourFrequencySlider extends StatefulWidget {
  final TextEditingController controller;

  SleepHourFrequencySlider({required this.controller});

  @override
  _SleepHourFrequencySlider createState() => _SleepHourFrequencySlider();
}

class _SleepHourFrequencySlider extends State<SleepHourFrequencySlider> {
  int _value = 1; // Valor inicial

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayColor: Colors.white.withOpacity(0.4),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: _value.toDouble(),
        onChanged: (newValue) {
          setState(() {
            _value = newValue.round();
            widget.controller.text = '$_value:00';
          });
        },
        min: 1,
        max: 24,
        divisions: 23,
        label: '$_value:00',
      ),
    );
  }
}

class FrequencyOfExternalPeople extends StatefulWidget {
  final TextEditingController controller;

  FrequencyOfExternalPeople({required this.controller});

  @override
  _FrequencyOfExternalPeople createState() => _FrequencyOfExternalPeople();
}

class _FrequencyOfExternalPeople extends State<FrequencyOfExternalPeople> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayColor: Colors.white.withOpacity(0.4),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: _value.toDouble(),
        onChanged: (newValue) {
          setState(() {
            _value = newValue.round();
            widget.controller.text = _value == 1
                ? 'Once a week'
                : _value == 2
                ? 'Twice a week'
                : 'Three times a week';
          });
        },
        min: 1,
        max: 3,
        divisions: 2,
        label: _value == 1
            ? 'Once a week'
            : _value == 2
            ? 'Twice a week'
            : 'Three times a week',
      ),
    );
  }
}

