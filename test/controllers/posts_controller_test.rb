require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers

  setup do
    @chapter = chapters(:chapter_3_of_3)
    @post = posts(:third_chapter_post_2)
    @user = users(:user)
    @admin = users(:admin)
    @unauthorized_user = User.create!(email: "unauthorized@test.com", password: "password")
    @admin_post = Post.create!(user: @admin, chapter: @chapter, title: "Admin Post Title", content: "Admin Post Content")
  end

  test 'if regular user is signed in, index loads' do
    sign_in @user
    get chapter_posts_url(@chapter)
    assert_response :success
  end

  test 'if no user is signed in, index redirects to sign in' do
    get chapter_posts_url(@chapter)
    assert_redirected_to new_user_session_path
  end

  test 'if regular user, create succeeds' do
    sign_in @user

    assert_difference('Post.count') do
      post chapter_posts_url(@chapter), params: { chapter_id: @chapter.id, post: { title: "New Test Post", content: "Test Post Content" } }
    end
  end

  test 'if admin, create succeeds' do
    sign_in @admin

    assert_difference('Post.count') do
      post chapter_posts_url(@chapter), params: { chapter_id: @chapter.id, post: { title: "New Test Post", content: "Test Post Content" } }
    end
  end

  # regular user can


  # regular user cannot

  # admin can

  # admin cannot

  test "edit fails is current user does not own post" do
    @unauthorized_user 
    sign_in @unauthorized_user
    get edit_chapter_post_url(@chapter, @post)
    assert_redirected_to chapter_posts_url(@chapter)
    assert_equal "You cannot edit that post", flash[:notice]
  end

  test "regular user can edit own posts" do
    sign_in @user
    get edit_chapter_post_url(@chapter, @post)
    assert_response :success
  end

  test "admin can edit own posts" do
    sign_in @admin
    get edit_chapter_post_url(@chapter, @admin_post)
    assert_response :success
  end

  test "admin cannot edit other user's posts" do
    sign_in @admin
    get edit_chapter_post_url(@chapter, @post)
    assert_redirected_to chapter_posts_url(@chapter)
    assert_equal "You cannot edit that post", flash[:notice]
  end

  test "regular user cannot update other user's posts" do
    sign_in @unauthorized_user
    assert_no_changes '@post.updated_at' do
      patch chapter_post_url(@chapter, @post), params: { post: { title: "Updated Title"}}
      @post.reload
    end
  end

  test "regular user can update own posts" do
    sign_in @user
    assert_changes '@post.updated_at' do
      patch chapter_post_url(@chapter, @post), params: { post: { title: "Updated Title"}}
      @post.reload
    end
  end

  test "admin can update own posts" do
    sign_in @admin
    assert_changes '@admin_post.updated_at' do
      patch chapter_post_url(@chapter, @admin_post), params: { post: { title: "Updated Title"}}
      @admin_post.reload
    end
  end

  test "admin cannot update other user's posts" do
    sign_in @admin
    assert_no_changes '@post.updated_at' do
      patch chapter_post_url(@chapter, @post), params: { post: { title: "Updated Title"}}
      @post.reload
    end
  end

  test "regular user cannot destroy other user's posts" do
    sign_in @unauthorized_user
    assert_no_difference('Post.count') do
      delete chapter_post_url(@chapter, @post)
    end
  end

  test "regular user can destroy own posts" do
    sign_in @user
    assert_difference('Post.count', -1) do
      delete chapter_post_url(@chapter, @post)
    end
  end

  test "admin can destroy own posts" do
    sign_in @admin
    assert_difference('Post.count', -1) do
      delete chapter_post_url(@chapter, @admin_post)
    end
  end

  test "admin cannot destroy other user's posts" do
    sign_in @admin
    assert_no_difference('Post.count') do
      delete chapter_post_url(@chapter, @post)
    end
  end

end

