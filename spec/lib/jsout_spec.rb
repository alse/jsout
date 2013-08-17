require "spec_helper"

describe "jsout" do
  context "template parsing" do
    it "outputs as_json" do
      post = Post.first
      post.jsout.should == post.as_json
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

      posts.jsout(:first).should == [{title: "First post 1"}, {title: "Second post 1"}]
      posts.jsout(:second).should == [{title: "First post 2"}, {title: "Second post 2"}]
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

      posts.jsout(:default).should == [{title: "First post"}, {title: "Second post"}]
    end

    it "parses activerecord relations" do
      posts = Post.scoped

      Jsout.present(:post) do
        template(:default) do |post|
          { title: post.title }
        end
      end

      posts.jsout(:default).should == [{title: "First post"}, {title: "Second post"}]
    end
  end

  context "include root" do
    it "includes the root if include_root: true" do
      posts = Post.scoped

      Jsout.present(:post) do
        template(:default, include_root: true) do |post|
          { title: post.title }
        end
      end

      posts.jsout(:default).should == {post: [{title: "First post"}, {title: "Second post"}]}
    end
  end
end