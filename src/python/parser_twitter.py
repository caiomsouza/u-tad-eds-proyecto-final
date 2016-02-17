import json
tweets = []

for line in open('output-20151214-934am.js'):
  try: 
    tweets.append(json.loads(line))
  except:
    pass


#print len(tweets)

tweet = tweets[0]
#print tweet

#print tweet.keys()

ids = []
for tweet in tweets:
  ids.append(tweet['id_str'])

ids = [tweet['id_str'] for tweet in tweets]
texts = [tweet['text'] for tweet in tweets]
times = [tweet['created_at'] for tweet in tweets]

source = [tweet['source'] for tweet in tweets]

#print tweet['user'].keys()

screen_names = [tweet['user']['screen_name'] for tweet in tweets]
names = [tweet['user']['name'] for tweet in tweets]
#description = [tweet['user']['description'] for tweet in tweets]
location = [tweet['user']['location'] for tweet in tweets]
user_url = [tweet['user']['url'] for tweet in tweets]
friends_count = [tweet['user']['friends_count'] for tweet in tweets]
followers_count = [tweet['user']['followers_count'] for tweet in tweets]
listed_count = [tweet['user']['listed_count'] for tweet in tweets]
favourites_count = [tweet['user']['favourites_count'] for tweet in tweets]
statuses_count = [tweet['user']['statuses_count'] for tweet in tweets]

#profile_banner_url = [tweet['user']['profile_banner_url'] for tweet in tweets]

#profile_banner_url = [(tweet['user']['profile_banner_url'] if tweet['user']['profile_banner_url'] else None) for tweet in tweets]

time_zone = [tweet['user']['time_zone'] for tweet in tweets]

#print tweet['entities']


for tweet in tweets:
  if tweet['entities']['user_mentions']:
    #print tweet['entities']['user_mentions']
    break


mentions1 = [(T['entities']['user_mentions'][0]['screen_name'] if len(T['entities']['user_mentions']) >= 1 else None) for T in tweets]
mentions2 = [(T['entities']['user_mentions'][1]['screen_name'] if len(T['entities']['user_mentions']) >= 2 else None) for T in tweets]
hashtags1 = [(T['entities']['hashtags'][0]['text'] if len(T['entities']['hashtags']) >= 1 else None) for T in tweets]
hashtags2 = [(T['entities']['hashtags'][1]['text'] if len(T['entities']['hashtags']) >= 2 else None) for T in tweets]
urls1 = [(T['entities']['urls'][0]['expanded_url'] if len(T['entities']['urls']) >= 1 else None) for T in tweets]
urls2 = [(T['entities']['urls'][1]['expanded_url'] if len(T['entities']['urls']) >= 2 else None) for T in tweets]


#print tweet['geo']

lats = [(T['geo']['coordinates'][0] if T['geo'] else None) for T in tweets]
lons = [(T['geo']['coordinates'][1] if T['geo'] else None) for T in tweets]

# retweet_count
# favorite_count

lang = [tweet['lang'] for tweet in tweets]

#retweet_count = [tweet['entities']['retweet_count'] for tweet in tweets]


#print tweet['place'].keys()

place_names = [(T['place']['full_name'] if T['place'] else None) for T in tweets]
place_types = [(T['place']['place_type'] if T['place'] else None) for T in tweets]

country_code = [(T['place']['country_code'] if T['place'] else None) for T in tweets]
country = [(T['place']['country'] if T['place'] else None) for T in tweets]


out = open('output-20151214-934am.csv', 'w')
print >> out, 'id,created,text,screen name,name,location,user_url,time_zone,mention 1,mention 2,hashtag 1,hashtag 2,url 1,url 2,lat,lon,place name,place type,lang,friends_count,followers_count,listed_count,favourites_count,statuses_count,country_code,country,source'

rows = zip(ids, times, texts, screen_names,  names, location, user_url, time_zone, mentions1, mentions2, hashtags1, hashtags2, urls1, urls2, lats, lons, place_names, place_types, lang, friends_count, followers_count, listed_count, favourites_count, statuses_count, country_code, country, source)

from csv import writer
csv = writer(out)

for row in rows:
    values = [(value.encode('utf8') if hasattr(value, 'encode') else value) for value in row]
    csv.writerow(values)

out.close()

print "done"
