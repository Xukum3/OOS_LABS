Name:          b20-515-17
Version:       1.0
Release:       1%{?dist}
Summary:       Программа студента Fedin Nikita группы B20-515
Group:         Testing
License:       GPL
URL:           https://github.com/Xukum3/OOS_LABS
Source0:       %{name}-%{version}.tar.gz
BuildRequires: /bin/rm, /bin/mkdir, /bin/cp
Requires:      /bin/bash, /usr/bin/date
BuildArch:     noarch

%description
A test package

%prep
%setup -q

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 b20-515-17 %{buildroot}%{_bindir}
sudo yum install gnuplot

%files
%{_bindir}/b20-515-17

%changelog
* Fri May 12 2023 Fedin
- Added %{_bindir}/b20-515-17
