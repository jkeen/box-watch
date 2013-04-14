describe("Shipment", function() {

  it("should be defined", function() {
    expect(BoxWatch.Models.Shipment).not.toBeUndefined();
  });

  describe("initialization", function() {
    var data, shipment;
    beforeEach(function() {
      data = {"created_at":"Sat, 13 Apr 2013 03:57:20 UTC +00:00", "delivery_at":null, "destination_city":"AUSTIN", "destination_country":"US", "destination_state":"TX", "id":57, "incoming_mail_id":null, "last_checked_at":"Sat, 13 Apr 2013 04:03:53 UTC +00:00", "last_error":null, "name":null, "notes":null, "origin_city":"CAMPBELLSVILLE", "origin_country":"US", "origin_state":"KY", "service":"ups", "service_type":"GROUND", "tracking_number":"1ZW22A280313531996", "updated_at":"Sat, 13 Apr 2013 04:03:53 UTC +00:00", "events":[
      {"city":null, "code":"M", "country":"US", "created_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00", "event_date":null, "event_time":null, "id":155, "name":"Billing Information Received", "notified_at":null, "occurred_at":"Mon, 08 Apr 2013 20:33:10 UTC +00:00", "postal_code":null, "shipment_id":57, "state":null, "updated_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00"},
      {"city":"DALLAS", "code":"I", "country":"US", "created_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00", "event_date":null, "event_time":null, "id":154, "name":"Origin Scan", "notified_at":null, "occurred_at":"Tue, 09 Apr 2013 18:27:00 UTC +00:00", "postal_code":null, "shipment_id":57, "state":"TX", "updated_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00"},
      {"city":"FORT WORTH", "code":"I", "country":"US", "created_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00", "event_date":null, "event_time":null, "id":153, "name":"Departure Scan", "notified_at":null, "occurred_at":"Wed, 10 Apr 2013 00:09:00 UTC +00:00", "postal_code":null, "shipment_id":57, "state":"TX", "updated_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00"},
      {"city":"AUSTIN", "code":"I", "country":"US", "created_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00", "event_date":null, "event_time":null, "id":152, "name":"Arrival Scan", "notified_at":null, "occurred_at":"Wed, 10 Apr 2013 03:30:00 UTC +00:00", "postal_code":null, "shipment_id":57, "state":"TX", "updated_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00"},
      {"city":"AUSTIN", "code":"I", "country":"US", "created_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00", "event_date":null, "event_time":null, "id":151, "name":"Out For Delivery", "notified_at":null, "occurred_at":"Wed, 10 Apr 2013 05:52:00 UTC +00:00", "postal_code":null, "shipment_id":57, "state":"TX", "updated_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00"},
      {"city":"AUSTIN", "code":"D", "country":"US", "created_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00", "event_date":null, "event_time":null, "id":150, "name":"Delivered", "notified_at":null, "occurred_at":"Wed, 10 Apr 2013 13:14:00 UTC +00:00", "postal_code":null, "shipment_id":57, "state":"TX", "updated_at":"Sat, 13 Apr 2013 03:57:21 UTC +00:00"}]};

      shipment = new BoxWatch.Models.Shipment(data);
    });

    it("creates locations and events", function() {
      expect(shipment.locations).toBeDefined();
      expect(shipment.events).toBeDefined();
    });

    describe("updating", function() {
      it('should not update frequently when found', function() {
        shipment.set({'found?': true});
        expect(shipment.pollTime).toEqual(1800000)
      });

      it("should be quick when not found", function() {
        shipment.set({'found?': false});
        expect(shipment.pollTime).toEqual(3000)
      });


    });


    describe("locations", function() {
      it("has correct count", function() {
        expect(shipment.locations.length).toEqual(4);
      });

      it("has events", function() {
        var austin = shipment.locations.findWhere({city: "AUSTIN"})
        expect(austin.events.length).toEqual(3);
      });
    })

    describe("events", function() {
      it("has correct count", function() {
        expect(shipment.events.length).toEqual(6);
      });

      it("orders by date", function() {
        expect(shipment.events.pluck('id')).toEqual([155, 154, 153, 152, 151, 150])
        expect(shipment.events.first().id).toEqual(155)
      });
    });


  });
});
