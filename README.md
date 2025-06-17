# UrbanBuy Chatbot App

A Flutter application implementing a chatbot for UrbanBuy using the Gemini API.

This application provides a chat interface where users can interact with a Gemini-powered chatbot configured to assist with UrbanBuy-related queries.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   **Flutter SDK:** Make sure you have the Flutter SDK installed. You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
*   **Dart SDK:** Included with Flutter.
*   An IDE like Android Studio (with Flutter plugin) or Visual Studio Code (with Flutter extension).

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-repository-url/urbanbuy_chatbot_app.git
    cd urbanbuy_chatbot_app
    ```
    *(Replace `https://github.com/your-repository-url/urbanbuy_chatbot_app.git` with the actual repository URL if applicable)*

2.  **Install dependencies:**
    Navigate to the project directory and run:
    ```bash
    flutter pub get
    ```
    This command fetches all the necessary packages defined in the `pubspec.yaml` file.

## API Key Setup

This application uses the Gemini API, which requires an API key to function.

1.  **Obtain a Gemini API Key:**
    If you don't have one, you'll need to obtain an API key from Google AI Studio or your cloud provider that offers Gemini models.

2.  **Configure the API Key:**
    *   In the root of the project, you will find a directory named `assets`.
    *   Inside the `assets` directory, there is a file named `config.json.example`.
    *   Create a copy of `config.json.example` and rename it to `config.json` within the same `assets` directory.
        ```bash
        cp assets/config.json.example assets/config.json
        ```
    *   Open `assets/config.json` with a text editor.
    *   Replace the placeholder `"YOUR_API_KEY_HERE"` with your actual Gemini API key. The file content should look like this:
        ```json
        {
          "apiKey": "YOUR_ACTUAL_GEMINI_API_KEY"
        }
        ```

3.  **Security Note:**
    The `assets/config.json` file (which contains your API key) is intentionally included in the `.gitignore` file. This prevents your actual API key from being accidentally committed to version control. **Do not remove this entry from `.gitignore` or share your `config.json` file publicly.**

## Running the Application

Once you have completed the installation and API key setup, you can run the application on a connected device or emulator.

1.  Ensure you have a device running or an emulator open.
2.  Navigate to the project directory in your terminal.
3.  Run the following command:
    ```bash
    flutter run
    ```

This will build and launch the application. You should see the UrbanBuy ChadBot interface, ready to interact.

## Project Structure (Brief Overview)

*   `lib/main.dart`: The main entry point of the application. Handles API key loading and initializes the main UI.
*   `assets/config.json`: Stores the Gemini API key (this file is gitignored).
*   `assets/config.json.example`: An example template for the API key configuration.
*   `pubspec.yaml`: Defines project metadata, dependencies, and assets.
*   `test/widget_test.dart`: Contains widget tests for the application.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
