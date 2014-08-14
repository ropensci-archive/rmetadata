# Each request debits your account by one. The maximum debt is 50 requests
# within a 30 second period. A request that exceeds the maximum debt will
# return a 503 HTTP response. You also receive 0.5 credits per second.
# You will continue to receive 503 until enough credits accumulate to drop
# your debt below 50 within 30 seconds.

# 'http[s]://babel.hathitrust.org/cgi/htd/:RESOURCE/:ID[/:FILEID|:SEQ][?:QUERY_STRING]'
# 
# library('httr')
# res <- GET('https://babel.hathitrust.org/cgi/htd/structure/mdp?format=xml&v=2&')
# stop_for_status(res)
# 
# res <- GET('https://babel.hathitrust.org/htd/volume/pageocr/dul1.ark:/13960/t00z82c1q/14')
# stop_for_status(res)
# 
# hathitrust_accesskey = "e7e0665525"
# hathitrust_secretkey = "0e3cb11e1cd1dcb98fa4c0085be8"
# getOption('hathitrust_accesskey')
# getOption('hathitrust_secretkey')
# 
# 
# github_auth <- function(appname=getOption('gh_appname'), key=getOption('gh_id'), secret=getOption('gh_secret')){
#   if(is.null(getOption('gh_token'))){
#     myapp <- oauth_app(appname, key, secret)
#     token <- oauth2.0_token(oauth_endpoints('github'), myapp)
#     options(gh_token = token)
#   } else { token <- getOption('gh_token') }
#   return( token )
# }
# 
# oauth_endpoints("twitter")
# 
# # 2. Register an application at https://apps.twitter.com/
# #    Insert your values below - if secret is omitted, it will look it up in
# #    the TWITTER_CONSUMER_SECRET environmental variable.
# myapp <- oauth_app("twitter", key = "TYrWFPkFAkn4G5BbkWINYw")
# 
# # 3. Get OAuth credentials
# twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)
# 
# # 4. Use API
# req <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",
#            config(token = twitter_token))
# stop_for_status(req)
# content(req)
