import 'package:agrilink/layouts/main_layout.dart';
import 'package:agrilink/models/offers_model.dart';
import 'package:agrilink/screens/info_screen.dart';
import 'package:agrilink/screens/main/dashboard.dart';
import 'package:agrilink/screens/main/profile.dart';
import 'package:agrilink/screens/main/services.dart';
import 'package:agrilink/services/services.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/category_button_green.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/draggable_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/app_localizations.dart';
import 'package:agrilink/screens/main/home.dart';

class OfferScreen extends StatefulWidget {
  final Offer offer;

  const OfferScreen({super.key, required this.offer});

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  bool _isSectionVisible = false; // Track the visibility of the section
  bool _isButtonVisible = true; // Track the visibility of the button
  int _requiredAmount = 0; // Track the required amount
  late int _negotiatePrice; // Track the required amount

  @override
  void initState() {
    super.initState();
    _negotiatePrice = widget.offer.price;
  }

  bool _isLoading = false;

  Future<void> _placeOffer() async {
    setState(() {
      _isLoading = true; // Set isLoading to true
    });
    final localizations = AppLocalizations.of(context);

    await OffersService().placeOffer(
      context,
      offerUid: widget.offer.uid,
      offerTitle: widget.offer.title,
      offerCategory: widget.offer.category,
      amount: _requiredAmount,
      negotiatedPrice: _negotiatePrice,
    );

    print(localizations.translate('service_posted'));

    setState(() {
      _isLoading = false; // Set isLoading to false
    });

    final theme = Theme.of(context);

    toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: Text(localizations.translate("Success!")),
        description: Text(localizations.translate('offer_made')),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: theme.colorScheme.primary,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        showProgressBar: false);

    setState(() {
      _isSectionVisible = false; // Hide the section
      _isButtonVisible = true; // Show the button
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 450,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.offer.avatar),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
              color: theme.colorScheme.background,
            ),
          ),
          const Positioned(
            top: 40, // Adjust the top position as needed
            left: 16, // Adjust the left position as needed
            child: BackButtonWidget(),
          ),
          DraggableWidget(
            initialChildSize: _isSectionVisible ? 0.8 : 0.6,
            maxChildSize: 0.9,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryButtonGreen(
                    text: localizations.translate(widget.offer.category),
                    onPressed: () {},
                  ),
                  
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      final phoneNumber = await OffersService().fetchPhoneNumber(widget.offer.uid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoScreen(
                                location: widget.offer.location,
                                avatar: widget.offer.avatar,
                                name: widget.offer.name,
                                description: widget.offer.description,
                                phone: phoneNumber),
                          ));
                    },
                    child: Row(
                      children: [
                        Text("Find on Map",
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      )),
                        const SizedBox(width: 10),
                        Icon(FluentIcons.location_28_regular,
                            color: theme.colorScheme.primary),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width:
                    double.infinity, // Ensures the Column takes the full width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.offer.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 28,
                        )),
                    Text(
                        '${widget.offer.category == 'Buyer' ? localizations.translate('I need') : localizations.translate('I have')} ${widget.offer.capacity} ${localizations.translate('Kilos')} ${widget.offer.category == 'Distributor' ? localizations.translate('in capacity') : widget.offer.category == 'Buyer' ? localizations.translate('of produce buyer') : localizations.translate('of produce farmer')}',                        
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(FluentIcons.star_three_quarter_28_regular,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Text(widget.offer.rating,
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: theme.colorScheme.onSecondary, fontSize: 18)),
                  const SizedBox(width: 40),
                  Icon(FluentIcons.clipboard_checkmark_24_regular,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Text('10+ offers',
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: theme.colorScheme.onSecondary, fontSize: 18))
                  
                ],
              ),
              const SizedBox(height: 30),
              Text(widget.offer.description,
                  textAlign: TextAlign.justify,
                  style: theme.textTheme.displaySmall?.copyWith(fontSize: 15)),
              const SizedBox(height: 30),

                if (widget.offer.category != 'Distributor')
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.primary, theme.colorScheme.error],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: SizedBox(
                  width: 330,
                  child: ElevatedButton(
                    onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MainLayout(
                          pages: [
                            HomeScreen(initialCategory: 'Distributor'),
                            ServicesScreen(),
                            DashboardScreen(),
                            ProfileDashboard(changeLanguage: (Locale locale) {}),
                          ],
                        ),
                      ),
                      (Route<dynamic> route) => false,
                    );
                    },
                    style: ElevatedButton.styleFrom(
                    foregroundColor: theme.colorScheme.onPrimary, 
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    ),
                    child: Text(
                    localizations.translate('Find a Distributor'),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  ),
                ),

              const SizedBox(height: 10),

              // Button that toggles the visibility of the extra section
              Visibility(
                visible: _isButtonVisible,
                child: PrimaryButtonDark(
                  text: localizations.translate('Make an offer'),
                  onPressed: () {
                    setState(() {
                      _isSectionVisible = true; // Show the section
                      _isButtonVisible = false; // Hide the button
                    });
                  },
                  expanded: true,
                ),
              ),
              const SizedBox(height: 20),

              // Animated appearance of the extra section
              AnimatedOpacity(
                opacity: _isSectionVisible ? 1.0 : 0.0,
                duration:
                    const Duration(milliseconds: 500), // Animation duration
                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 500), // Animation duration
                  curve: Curves.easeInOut, // Animation curve for smoothness
                  child: _isSectionVisible
                      ? Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // Align left
                            mainAxisSize: MainAxisSize
                                .min, // Take only the available space
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${widget.offer.category == 'buyer' ? localizations.translate('Provided') : localizations.translate('Required')} ${widget.offer.category == 'distributer' ? localizations.translate('Capacity') : localizations.translate('Stock')}',
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Minus button
                                    IconButton(
                                      icon: Icon(
                                          FluentIcons.caret_left_24_filled,
                                          color: theme.colorScheme.primary),
                                      onPressed: () {
                                        setState(() {
                                          if (_requiredAmount > 0) {
                                            _requiredAmount--;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '$_requiredAmount Kg',
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          FluentIcons.caret_right_24_filled,
                                          color: theme.colorScheme.primary),
                                      color: theme.colorScheme.primary,
                                      onPressed: () {
                                        setState(() {
                                          _requiredAmount++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        localizations.translate('Negotiate Price'),
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Minus button
                                    IconButton(
                                      icon: Icon(
                                          FluentIcons.caret_left_24_filled,
                                          color: theme.colorScheme.primary),
                                      onPressed: () {
                                        setState(() {
                                          if (_negotiatePrice > 0) {
                                            _negotiatePrice -= 10;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '$_negotiatePrice ${widget.offer.category == 'distributer' ? 'Rs./Km' : 'Rs./Kg'}',
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          FluentIcons.caret_right_24_filled,
                                          color: theme.colorScheme.primary),
                                      color: theme.colorScheme.primary,
                                      onPressed: () {
                                        setState(() {
                                          _negotiatePrice += 10;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        localizations.translate('Total Price'),
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Rs. ${_requiredAmount * _negotiatePrice}',
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontSize: 18,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: _isLoading
                                    ? CircularProgressIndicator() // Show loading indicator
                                    : PrimaryButtonDark(
                                        text: localizations.translate('Place Offer'),
                                        onPressed: _placeOffer,
                                        expanded: true,
                                      ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
