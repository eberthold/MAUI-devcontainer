# POC MAUI Devcontainer for Android
Very basic showcase of how to develop dotnet MAUI for Android in a devcontainer with the ability to deploy to a central emulator or device on the host.  

## Prerequisites
- Podman (see "Why podman" for possible adjustments)
- VS Code with podman set as docker path (or something like DevPod)
- Emulator with latest adb on host

## Why emulator on host?
For some projects where creating test data because of complex environment constraints isn't that simple persisting the apps state across devcontainer rebuilds can be benefitial.

## Why podman instead of docker
Because we use it at work and I'm exploring Fedora at the moment as well.

#### podman extras
The devcontainer.json has some extra parts for testing if it also is usable with podman. For plain docker you may have to change following parts:
- remove runargs
- remove the trailing Z of the workspaceMount
    - workspace mount might be removed entirely
- containerUser might be removable

## Usage
To deploy to a emulator or device, running an adb server with `adb kill-server; adb -a start-server` on the host is necessary. The kill is to ensure an new server will be spawned with the expected parameters.   
  
For some reason `dotnet build -t:Run` does not see the emulator at the host, thats why the makefile with `make deploy` exists. 

### Alternative considerations (maybe if app setup is easy)
To workaround the emulator connection issues, there are several guides how to setup a vnc connection from host to the devcontainer which would also prevent having to install the emulator and sdk on the host. This also should mitigate the `dotnet build -t:Run` issue and enable debugability from VS Code. In this case the `ADB_SERVER_SOCKET` environment variable must be removed from the dockerfile, and set per session if needed. _But keep in mind that the emulator maybe is in a fresh state after a devcontainer rebuild_    

For real device connections at least an adb server must be running on the host, and env var must be present. But it will have the same caveat of needing the makefile and not being able to debug. (Logcat is your friend here)