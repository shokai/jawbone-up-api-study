Jawbone Up API Study
====================

- [橋本商会 » Jawbone UpのAPIで睡眠時間などを取得する](http://shokai.org/blog/archives/8742)


## Register Your App

- https://jawbone.com/up/developer/

![register app](http://gyazo.com/a0ffdb899e0eea1685ff4532c7b4755a.png)

## Auth

    % cd auth/
    % export APP_SECRET=your-app-token
    % export CLIENT_ID=your-app-client-id
    % bundle exec rackup config.ru -p 5000
    % open http://localhost:5000

=> get TOKEN


## Get Sleeps

    % export JAWBONE_TOKEN=your-token
    % bundle exec ruby sleep.rb

