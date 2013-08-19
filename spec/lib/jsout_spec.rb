require "spec_helper"

describe "jsout" do
  context "template parsing" do
    it "outputs as_json" do
      post = Post.first
      post.jsout.should == post.to_json
    end

    it "outputs multiple custom templates" do
      posts = Post.first(2)

      Jsout.present(:post) do
        template(:first) do |post|
          { title: post.title + " 1" }
        end

        template(:second) do |post|
          { title: post.title + " 2" }
        end
      end

      posts.jsout(:first).should == [{title: "First post 1"}, {title: "Second post 1"}].to_json
      posts.jsout(:second).should == [{title: "First post 2"}, {title: "Second post 2"}].to_json
    end
  end


  context "parsing multiple objects" do
    it "parses arrays of active_record objects" do
      posts = Post.all

      Jsout.present(:post) do
        template(:default) do |post|
          { title: post.title }
        end
      end

      posts.jsout(:default).should == [{title: "First post"}, {title: "Second post"}].to_json
    end

    it "parses activerecord relations" do
      posts = Post.scoped

      Jsout.present(:post) do
        template(:default) do |post|
          { title: post.title }
        end
      end

      posts.jsout(:default).should == [{title: "First post"}, {title: "Second post"}].to_json
    end
  end

  context "include custom root" do
    it "includes the root if include_root: true" do
      posts = Post.scoped

      Jsout.present(:post) do
        template(:default, root: :posts) do |post|
          { title: post.title }
        end
      end

      posts.jsout(:default).should == {posts: [{title: "First post"}, {title: "Second post"}]}.to_json
    end
  end

  context "include another hash" do
    it "includes another hash" do
      posts = Post.scoped

      Jsout.present(:post) do
        template(:default, root: :posts) do |post|
          { title: post.title }
        end
      end

      posts.jsout(:default, include: {another: "hash"}).should == {:posts=>[{:title=>"First post"}, {:title=>"Second post"}], :another=>"hash"}.to_json
    end
  end
end