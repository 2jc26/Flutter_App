import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';


class FilterUsersOthers extends StatelessWidget {
  const FilterUsersOthers({Key? key}) : super(key: key);

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
                  ExclusiveCheckboxGroup(labels: const ['Yes', 'No']),
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
                  ExclusiveCheckboxGroup(labels: const ['Introverted', 'Extroverted']),
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
              CleaningFrequencySlider(),
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
                  ExclusiveCheckboxGroup(labels: const ['Yes', 'No']),
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
                  ExclusiveCheckboxGroup(labels: ['Yes', 'No']),
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
                  ExclusiveCheckboxGroup(labels: ['Yes', 'No']),
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
              SleepHourFrequencySlider(),
              const Text(
                'How many times will you bring people a week?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const FrequencyOfExternalPeople(),
            ],
          ),
        ),
      ),
    );
  }
}

class ExclusiveCheckboxGroup extends StatefulWidget {
  final List<String> labels;

  ExclusiveCheckboxGroup({required this.labels});

  @override
  _ExclusiveCheckboxGroupState createState() => _ExclusiveCheckboxGroupState();
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
  @override
  _CleaningFrequencySliderState createState() => _CleaningFrequencySliderState();
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
      )
    );
  }
}

class SleepHourFrequencySlider extends StatefulWidget {
  @override
  _SleepHourFrequencySlider createState() => _SleepHourFrequencySlider();
}

class _SleepHourFrequencySlider extends State<SleepHourFrequencySlider> {
  int _value = 1; // Valor inicial

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayColor: Colors.white.withOpacity(0.4), // Color del overlay al tocar el slider
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white, // Cambia el color del texto del label aquí
        ),
      ),
      child: Slider(
        value: _value.toDouble(),
        onChanged: (newValue) {
          setState(() {
            _value = newValue.round();
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
  const FrequencyOfExternalPeople({super.key});

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
        )
    );
  }
}

