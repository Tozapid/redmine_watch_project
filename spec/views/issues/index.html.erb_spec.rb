require_relative '../../spec_helper'

describe "issues/index" do
  before do
    User.current = User.find(1)
    assign(:query, stub_model(IssueQuery))
    assign(:issues, [])
    view.extend RoutesHelper
    view.extend QueriesHelper
  end

  it "doesn't contain 'watch' or 'unwatch' links when not inside a project" do
    render
    assert_select "div.contextual>a.icon-fav", :count => 0
    assert_select "div.contextual>a.icon-fav-off", :count => 0
  end

  it "contains an 'unwatch' link for the project if watching" do
    assign(:project, stub_model(Project, :watcher_users => []))
    render
    assert_select "div.contextual>a.icon-fav-off", :text => "Watch"
  end

  it "contains an 'watch' link for the project if not watching" do
    assign(:project, stub_model(Project, :watcher_users => [User.current]))
    render
    assert_select "div.contextual>a.icon-fav", :text => "Unwatch"
  end
end
