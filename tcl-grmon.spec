%define teaname GrapheneMonitor
%define major 1.3

Name: tcl-grmon
Version: %major
Release: alt1
BuildArch: noarch

Summary: GrapheneMonitor library, monotor frame and modules
Group: System/Libraries
Source: %name-%version.tar
License: Unknown

Requires: tcl

%description
tcl-grmon -- GrapheneMonitor library, monotor frame and modules
%prep
%setup -q

%build
mkdir -p %buildroot/%_tcldatadir/%teaname
install -m644 *.tcl %buildroot/%_tcldatadir/%teaname

%files
%dir %_tcldatadir/%teaname
%_tcldatadir/%teaname/*.tcl

%changelog
