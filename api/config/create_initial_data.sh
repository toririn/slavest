if [ $1 = "create" ]; then
  bundle exec rake users:create
  bundle exec rake channels:create
  bundle exec rake emovalue_options:create
else
  echo "create? update? It use by [create] parameter"
fi
