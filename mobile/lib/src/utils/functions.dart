
/// Compares the versions to ensure it can execute
bool compareVersion(String currentVersion, String minimumVersion) {
  return currentVersion.compareTo(minimumVersion) >= 0;
}