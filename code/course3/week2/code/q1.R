library(httr);
html = GET("https://api.github.com/users/jtleek/repos");
json1 = content(html);
json2 = jsonlite::fromJSON(toJSON(json1));
json2[json2$name == 'datasharing',]$created_at;
