import 'package:finders_v1_1/client_portal/screens/all_companies.dart';
import 'package:finders_v1_1/client_portal/screens/booking.dart';
import 'package:finders_v1_1/client_portal/screens/client_pro.dart';
import 'package:finders_v1_1/client_portal/screens/client_profile.dart';
import 'package:finders_v1_1/client_portal/screens/about_us.dart';
import 'package:finders_v1_1/client_portal/screens/appointment_page.dart';
import 'package:finders_v1_1/client_portal/screens/client_details.dart';
import 'package:finders_v1_1/client_portal/screens/client_home.dart';
import 'package:finders_v1_1/client_portal/screens/client_login.dart';
import 'package:finders_v1_1/client_portal/screens/client_reg.dart';
import 'package:finders_v1_1/client_portal/screens/contact_us.dart';
import 'package:finders_v1_1/main_page.dart';
import 'package:finders_v1_1/service_provider_portal/pages/provider_profile.dart';
import 'package:finders_v1_1/service_provider_portal/pages/service_provider_home.dart';
import 'package:finders_v1_1/service_provider_portal/pages/service_provider_login.dart';
import 'package:finders_v1_1/service_provider_portal/pages/service_provider_reg.dart';
import 'package:flutter/material.dart';

//   a main landing page

class RouteManager {
  static const String mainPage = '/';
  static const String clientHomePage = '/clientHomePage';
  // ignore: constant_identifier_names
  static const String allCompaniesPage = '/allCompaniesPage';
  static const String clientLoginPage = '/clientLoginPage';
  static const String clientRegistrationPage = '/clientRegistrationPage';
  static const String serviceProviderHomePage = '/serviceProviderHomePage';
  static const String serviceProviderLoginPage = '/serviceProviderLoginPage';
  static const String partnerRegistrationPage = '/partnerRegistrationPage';
  static const String profilePage = '/profilePage';
  static const String serviceProfilePage = '/serviceProfilePage';
  static const String proPicPage = '/proPicPage';
  static const String appointmentPage = '/appointmentPage';
  static const String detailsPage = '/detailsPage';
  static const String aboutUsPage = '/aboutUsPage';
  static const String contactUsPage = '/contactUsPage';
  static const String bookingPage = '/bookingPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case clientHomePage:
        return MaterialPageRoute(builder: (context) => const ClientHomePage());
      case clientLoginPage:
        return MaterialPageRoute(builder: (context) => const ClientLoginPage());
      case clientRegistrationPage:
        return MaterialPageRoute(
            builder: (context) => const ClientRegistrationPage());
      case bookingPage:
        return MaterialPageRoute(
            builder: (context) => const BookingPage(
                  serviceProviderId: '',
                ));
      case appointmentPage:
        return MaterialPageRoute(builder: (context) => const AppointmentPage());

      case detailsPage:
        var appointmentId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(appointmentId: appointmentId),
        );
      case serviceProviderHomePage:
        return MaterialPageRoute(
            builder: (context) => const ServiceProviderHome());
      case serviceProviderLoginPage:
        return MaterialPageRoute(
            builder: (context) => const ServiceProviderLoginPage());
      case partnerRegistrationPage:
        return MaterialPageRoute(
            builder: (context) => const PartnerRegistrationPage());
      case serviceProfilePage:
        return MaterialPageRoute(
            builder: (context) => const ServiceProfilePage());
      case allCompaniesPage:
        return MaterialPageRoute(
            builder: (context) => const AllCompaniesPage());

      case profilePage:
        return MaterialPageRoute(builder: (context) => const ProfilePage());
      case proPicPage:
        return MaterialPageRoute(builder: (context) => const ProPicPage());
      case aboutUsPage:
        return MaterialPageRoute(builder: (context) => const AboutUsPage());
      case contactUsPage:
        return MaterialPageRoute(builder: (context) => const ContactUsPage());
      default:
        throw Exception('Route not found');
    }
  }
}
