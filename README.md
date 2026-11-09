# GDP dashboard

This repository contains two starter apps:

- A Streamlit GDP-by-country dashboard at the repository root.
- A Flutter GDP and logistics operations dashboard in `flutter_app/`.

## Run the Streamlit dashboard

Install the requirements and start the app:

```sh
pip install -r requirements.txt
streamlit run streamlit_app.py
```

## Run the Flutter dashboard

Install the [Flutter SDK](https://docs.flutter.dev/get-started/install), then run:

```sh
cd flutter_app
# Generate platform runner files on first setup.
flutter create .
flutter pub get
flutter run
```

The Flutter app is an initial UI scaffold with responsive navigation, sample GDP
and shipment metrics, and clearly labeled placeholder sections. Its displayed
operations figures are illustrative and are not connected to a live data source.
