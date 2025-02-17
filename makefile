build:
	# disable fast deployment with EmbedAssembliesIntoApk=true because it leads to errors sometimes
	dotnet build -p:EmbedAssembliesIntoApk=true

deploy: build
	adb install src/Maui.Startup/Maui.Startup.Droid/bin/Debug/net8.0-android/com.companyname.maui.startup-Signed.apk
