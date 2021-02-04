
・"tasks"table
    string "title"
    text "content"
    bigint "user_id"

・"users"table
    string "name"
    string "email"
    string "password_digest"

    〜heroku手順〜
    heroku login
    rails assets:precompile RAILS_ENV=production
    git add -A
    git commit -m "init"
    heroku create
    heroku stack:set heroku-18
    heroku buildpacks:set heroku/ruby　※時によっては必要
    heroku buildpacks:add --index 1 heroku/nodejs ※時によっては必要
    git push heroku master
    heroku run rails db:migrate
    heroku config ※url確認（今回はglacial-thicket-22858）
    https://glacial-thicket-22858.herokuapp.com/
    にアクセスして動作確認