Name:       c-b20-515-17
Version:    1.0
Release:    1%{?dist}
Summary:    Программа студента Fedin Nikita группы B20-515
Group:      Testing
License:    GPL
URL:        https://github.com/Xukum3/OOS_LABS
Source:     %{name}-%{version}.tar.gz
BuildRequires: gcc

%global debug_package %{nil}

%description
A test package

%prep
%setup -q

%build
gcc -O2 -o c-b20-515-17 c-b20-515-17.c

%install
mkdir -p %{buildroot}%{_bindir}
cp c-b20-515-17 %{buildroot}%{_bindir}
sudo rpm -i ~/rpmbuild/RPMS/noarch/b20-515-17-1.0-1.el8.noarch.rpm --force

%files
%{_bindir}/c-b20-515-17

%changelog
* Fri May 12 2023 Fedin
- Added %{_bindir}/c-b20-515-17

