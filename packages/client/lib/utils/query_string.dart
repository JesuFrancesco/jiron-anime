String parseToQueryParams(Map<String, Object> queryParamsMap) {
  return queryParamsMap.entries
      .map(
        (e) => "${e.key}=${e.value}",
      )
      .join("&");
}
