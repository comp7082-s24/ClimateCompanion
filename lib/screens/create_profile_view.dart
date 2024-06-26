import "package:climate_companion/constants.dart";
import "package:climate_companion/navigation.dart";
import "package:climate_companion/state/app_state_provider.dart";
import "package:climate_companion/themes/theme.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final TextEditingController _dateController = TextEditingController();
  String? _name;
  DateTime? _dob;
  Color? _favouriteColour;

  bool formIsValid() {
    return _name != null && _name!.isNotEmpty && _dob != null && _favouriteColour != null;
  }

  @override
  Widget build(final BuildContext context) {
    const columSeparator = SizedBox(height: 16);
    const sectionSeparator = SizedBox(height: 32);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Flexible(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          Constants.onBoardingWelcomeTitle,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(Constants.onBoardingWelcomeMessage),
                        ),
                      ),
                    ),
                    sectionSeparator,
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              labelText: "Name",
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+"))],
                            onChanged: (final value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                          columSeparator,
                          TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            mouseCursor: SystemMouseCursors.click,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              labelText: "Date of Birth",
                              border: OutlineInputBorder(),
                            ),
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1924),
                                lastDate: DateTime.now(),
                              );
                              setState(() {
                                _dob = selectedDate;
                                if (selectedDate == null) {
                                  _dateController.clear();
                                } else {
                                  _dateController.text = DateFormat.yMMMd().format(selectedDate);
                                }
                              });
                            },
                          ),
                          columSeparator,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Favourite Colour"),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...colours.map(
                                      (final colour) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _favouriteColour = colour;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: colour == _favouriteColour ? Colors.green : Colors.transparent,
                                              width: 2,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.circle,
                                            color: colour == _favouriteColour ? colour : colour,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    sectionSeparator,
                    Flexible(
                      child: FilledButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 16)),
                        ),
                        onPressed: submitForm(context),
                        child: const Text(Constants.saveButtonTitle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              Constants.createdByMessage,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }

  void Function()? submitForm(final BuildContext context) {
    return formIsValid()
        ? () {
            Provider.of<AppStateProvider>(context, listen: false).setName(_name!);
            Provider.of<AppStateProvider>(context, listen: false).setDob(_dob!);
            Provider.of<AppStateProvider>(context, listen: false).setFavouriteColour(_favouriteColour!);
            Provider.of<AppStateProvider>(context, listen: false).setIsProfileComplete(true);
            context.goNamed(WeatherDestination().name!);
          }
        : null;
  }
}
