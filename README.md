#### Jsout

Easy json presenters for your models.

```ruby
gem "jsout", github: "alse/jsout"
```

#### To set up the presenters:

```ruby
Jsout.present(:post) do
  template(:default) do |work|
    { 
      title: post.title
    }
  end

  template(:index) do |work|
    { 
      title: post.title + " on index page" 
    }
  end
end
```

#### Using a presenter:

```ruby
  posts = Post.all

  posts.jsout                                     # <= Uses the :default template
  posts.jsout(:index)                             # <= Uses the :index template
  posts.jsout(:index, root: :posts)               # <= Adds root :posts
  posts.jsout(:index, include: {another: "hash")  # <= Includes another hash
```
