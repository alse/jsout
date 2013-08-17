# Jsout

Easy json presenters for your models.

gem "jsout", github: "alse/jsout"


# To set up the presenters:

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

# Using a presenter:
  
  posts = Post.all

  posts.jsout          # <= Uses the :default template
  posts.jsout(:index)  # <= Uses the :index template
