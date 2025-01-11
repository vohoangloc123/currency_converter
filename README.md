# Currency Converter

## 1. Application Structure Description

### Purpose
The application helps users convert currencies between countries, automatically updates exchange rates, and validates inputs while displaying real-time exchange rates.

### Key Features
- **Enter Amount**: Supports valid number formatting, disallows negative numbers and non-numeric characters.  
- **Select Currency Unit**: Users can choose currency units from a list (USD, VND, EUR, GBP, etc.).  
- **Currency Conversion**: Calculates conversion results based on current exchange rates.  
- **Swap Currencies**: Switch positions between "From Currency" ↔ "To Currency".  
- **Display Results**: Shows the converted amount and the target currency unit.  
- **Real-Time Exchange Rate Chart**: Displays exchange rates in a bar chart.

### Application Structure

#### Frontend (UI)
- **Language**: Flutter (Dart)  
- **Libraries**:  
  - `flutter_dotenv`: ^5.2.1 - Manages environment variables, stores API keys and configurations in a `.env` file.  
  - `flutter_spinkit`: ^5.2.1 - Provides beautiful and easy-to-use loading spinners.  
  - `http`: ^1.2.2 - Sends HTTP requests (GET, POST, PUT, DELETE, etc.) from Flutter to APIs or web services.  
  - `google_fonts`: ^6.2.1 - Enables easy usage of Google Fonts in Flutter without manual font loading.  

#### Main Screen
- Input the amount, select source and target currencies.  
- Includes a "Convert" button and a "Swap" button to switch between the two currencies.  
- Displays conversion results.  
#### Exchange Rate Analysis Screen:  
- Displays a real-time exchange rate chart.  
#### Backend (Logic & API)

- **Features**:  
  - Fetches exchange rates using a third-party API (ExchangeRateAPI).  
  - Validates input data:  
    - Amount must be greater than 0.  
    - VND must be an integer.  
    - Source and target currencies must be different.  
  - Handles errors if the API fails to return results or encounters network issues.  
  - Displays a real-time exchange rate chart. 

#### Technologies:
- **Logic**: Calculation logic is implemented in Dart.  
- **API Calls**: Managed via the `http` library.  
- **Input Validation**:  
  - Ensures valid and positive amounts.  
  - Checks input currency format.  
  - Validates that "From Currency" and "To Currency" are different.  
  - Ensures "VND" is entered as an integer.  

### Directory Structure
```plaintext
lib/  
├── main.dart                                # Application entry point  
├── screens/  
    ├── currency_converter_screen.dart       # Main currency conversion screen  
    ├── analysts_screen.dart                 # Exchange rate analysis screen  
├── services/  
    ├── currency_converter.dart              # API class for fetching exchange rates  
    ├── fetch_exchange_rates.dart            # API class for fetching rates for the bar chart  
├── widgets/  
    ├── chart_painter.dart                   # Bar chart widget  

```
## 2 Guide to Building and Running the Application
1 Installing Flutter:
Download and install the Flutter SDK from Flutter's official website.<br> Ensure that Android Studio or VS Code is installed, and the Flutter development environment is properly configured.<br>

2 Installing Dependencies: <br>
- Step 1: Open a terminal or command prompt and navigate to the project directory.<br>

- Step 2: Run the following command to install all required packages:
```flutter pub get```<br>

- Step 3: Configure the API Key:

Visit https://www.exchangerate-api.com and create an account.<br>
After registering, the website will provide you with an API key.<br>
Create a .env file in the root/assets/ directory of the project.<br>
Open the .env file and add the following line to save the API key:
```API_KEY=your_api_key_here<br>```
- Step 4: Run the application on an emulator or a physical device:

Connect a physical device via USB or launch an emulator (Android Emulator/iOS Simulator).
Note: Ensure that Developer Mode is enabled on the physical device.<br>
Step 5: Run the application using the command:
flutter run<br>

Step 6: Build the application for release:

For Android: flutter build apk
For iOS: flutter build ios<br>
Step 7: Test the application:

Once the application is running, test key features such as currency conversion, data input, and result display.<br>
## 3 Notes or Challenges Encountered
Challenges with ExchangeRate API:
Query Limit: The free version of the ExchangeRate API allows a maximum of 1,500 requests per month. If more requests are required, consider optimizing usage or upgrading to a paid version.<br>
Notes:
Even if I am not selected, I sincerely hope to receive feedback on my application. Although it is a small project, I have dedicated a lot of time and effort to it. Your suggestions and feedback will help me grow and improve further. Thank you very much!<br>
