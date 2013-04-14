describe("Location", function() {
  it("should be defined", function() {
    expect(BoxWatch.Models.Location).not.toBeUndefined();
  });

  it("should organize by city, not by zip", function() {
    var locations = new BoxWatch.Collections.Locations()
    locations.addByEvent(new BoxWatch.Models.Event({city: "Austin", state: "TX", postal_code: "78745"}));
    locations.addByEvent(new BoxWatch.Models.Event({city: "Austin", state: "TX", postal_code: "78740"}));

    expect(locations.length).toBe(1);
  });

});
