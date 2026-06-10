require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def build_shipable_project(code_hours:, last_shipped_code_hours: 0)
    project = Project.create!(
      user: users(:one),
      title: "My Project",
      description: "My description",
      code_hours: code_hours,
      art_hours: 0,
      status: "unshipped",
      last_shipped_code_hours: last_shipped_code_hours
    )

    project.thumbnail.attach(
      io: file_fixture("thumbnail.png").open,
      filename: "thumbnail.png",
      content_type: "image/png"
    )

    project
  end

  test "requires at least 5 hours before first ship" do
    project = build_shipable_project(code_hours: 4.9)

    assert_includes project.shipping_incomplete_reasons, "Please reach at least 5 Hackatime hours before shipping."
    assert_not project.ready_for_shipping?
  end

  test "requires 5 additional hours after a previous ship" do
    project = build_shipable_project(code_hours: 14.0, last_shipped_code_hours: 10.0)

    assert_includes project.shipping_incomplete_reasons, "Please earn 5 additional Hackatime hours since your last ship."
    assert_not project.ready_for_shipping?

    project.update!(code_hours: 15.0)

    assert project.ready_for_shipping?
    assert_empty project.shipping_incomplete_reasons
  end

  test "mark_as_shipped stores the current code hours" do
    project = build_shipable_project(code_hours: 8.25)

    project.mark_as_shipped!

    assert_equal "pending_review", project.status
    assert_equal 8.25, project.last_shipped_code_hours.to_f
  end
end
