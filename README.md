# GPA Calculator App

## Overview

The GPA Calculator App is a customizable and user-friendly application developed using Flutter. It allows users to define their own grading point system, manage semesters, add modules, and calculate their GPA.

## Features

- **Customizable Grading Point System**: Users can set up their grading point system according to their preferences or institutional requirements.
- **View Only Grading System**: Once set, the grading point system is view-only to prevent accidental changes.
- **Home Screen**: Displays the total GPA credits, total non-GPA credits, and the calculated GPA.
- **Semesters Management**: Users can add or delete semesters and manage modules within each semester.
- **Settings**: Displays the grading system in a read-only format.

## Installation

1. Download the latest release version of the app [https://github.com/Shilpa-Perera/gpa_calculator/releases/tag/pre-relese](#) (link to the APK).
2. Transfer the APK file to your Android device.
3. Open the APK file and follow the on-screen instructions to install the app.

## Usage

### Initial Setup

1. **Add Grading Point System**: On first launch, users will be prompted to set up their grading point system. This step is mandatory and ensures the app calculates GPA accurately.
   - Input the grading points corresponding to each grade.
   - Once saved, the grading system cannot be edited but can be viewed in the settings.

### Navigation

#### Home

- **GPA Overview**: Displays the total GPA credits, total non-GPA credits, and the cumulative GPA.

#### Semesters

- **View Semesters**: List all the semesters added by the user.
- **Add Semester**: Use the add function to create a new semester.
- **Manage Modules**: Click on a semester to view and add modules. Existing modules can also be deleted from this screen.

#### Settings

- **View Grading System**: Displays the grading point system in a read-only format to ensure transparency and prevent modifications.

## Screenshots

![](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExeXh0NmM4N2NnOHhlamVoZnd3a2pzMmN5NXI0enA4ZDl1eW5meWE1eiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/W4ym9VCLNCacCdiDLJ/giphy.gif)

## Development

### Requirements

- Flutter SDK
- Dart

### Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/gpa_calculator_app.git
2. Navigate to the project directory
   ```sh
   cd gpa_calculator_app
3. Install dependencies
   ```sh
   flutter pub get
4. Run the app
   ```sh
   flutter run
