require 'test_helper'

class IncomingMailsControllerTest < ActionController::TestCase
  test "incoming mail from external service is received" do
    post_successful_message
    assert_response :success
  end
  
  test "message with invalid signature gets 403" do
    post_invalid_message
    assert_response 403
  end
  
  test "incoming mail gets created" do
    assert_difference "IncomingMail.count" do
      post_successful_message
    end
  end
  
  test "shipment gets created with successful mailing containing tracking number" do
    post_successful_message
    assert_equal 1, Shipment.where(:tracking_number => '1Z5R89390262095290').count
  end
  
  def post_invalid_message
    post :create, {
      "html"=>"<span class=\"Apple-style-span\" style=\"font-family: arial, sans-serif; font-size: 13px; border-collapse: collapse; \">Amazon.com items (Sold by Amazon.com, LLC) :<br><br>\240 1 \240General Tools IRT206 Infar... \240 $46.62 \240 \240 \240 \240 \240 \240 \240 1 \240 $46.62<br>\r\n\r\n<br>Shipped via UPS<br><br><span class=\"il\" style=\"background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: rgb(255, 255, 204); color: rgb(34, 34, 34); background-position: initial initial; background-repeat: initial initial; \">Tracking</span>\240<span class=\"il\" style=\"background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: rgb(255, 255, 204); color: rgb(34, 34, 34); background-position: initial initial; background-repeat: initial initial; \">number</span>: 1Z5R89390262095290<br>\r\n\r\n<br>--------------------------------------------------------------------<br>\240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240Item Subtotal: \240 \240 $46.62<br>\240 \240 \240 \240 \240 \240 \240 \240 Shipping \240and handling: \240 \240 \240$0.00<br>\240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240Total: \240 \240 $46.62<br>\r\n\r\n\240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 Paid by Visa: \240 \240 $46.62<br>--------------------------------------------------------------------</span>", 
      "plain"=>"Amazon.com items (Sold by Amazon.com, LLC) :\n\n  1  General Tools IRT206 Infar...   $46.62               1   $46.62\n\nShipped via UPS\n\nTracking number: 1Z5R89390262095290\n\n--------------------------------------------------------------------\n                         Item Subtotal:     $46.62\n                Shipping  and handling:      $0.00\n                                 Total:     $46.62\n                          Paid by Visa:     $46.62\n--------------------------------------------------------------------", 
      "from"=>"jeffxl@gmail.com", 
      "signature"=>"baeab82254bfecd9ad8a827dab1bbc32" }
  end
  
  def post_successful_message
    post :create, {
      "html"=>"<span class=\"Apple-style-span\" style=\"font-family: arial, sans-serif; font-size: 13px; border-collapse: collapse; \">Amazon.com items (Sold by Amazon.com, LLC) :<br><br>\240 1 \240General Tools IRT206 Infar... \240 $46.62 \240 \240 \240 \240 \240 \240 \240 1 \240 $46.62<br>\r\n\r\n<br>Shipped via UPS<br><br><span class=\"il\" style=\"background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: rgb(255, 255, 204); color: rgb(34, 34, 34); background-position: initial initial; background-repeat: initial initial; \">Tracking</span>\240<span class=\"il\" style=\"background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: rgb(255, 255, 204); color: rgb(34, 34, 34); background-position: initial initial; background-repeat: initial initial; \">number</span>: 1Z5R89390262095290<br>\r\n\r\n<br>--------------------------------------------------------------------<br>\240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240Item Subtotal: \240 \240 $46.62<br>\240 \240 \240 \240 \240 \240 \240 \240 Shipping \240and handling: \240 \240 \240$0.00<br>\240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240Total: \240 \240 $46.62<br>\r\n\r\n\240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 \240 Paid by Visa: \240 \240 $46.62<br>--------------------------------------------------------------------</span>", 
      "plain"=>"Amazon.com items (Sold by Amazon.com, LLC) :\n\n  1  General Tools IRT206 Infar...   $46.62               1   $46.62\n\nShipped via UPS\n\nTracking number: 1Z5R89390262095290\n\n--------------------------------------------------------------------\n                         Item Subtotal:     $46.62\n                Shipping  and handling:      $0.00\n                                 Total:     $46.62\n                          Paid by Visa:     $46.62\n--------------------------------------------------------------------", 
      "disposable"=>"", 
      "from"=>"jeffxl@gmail.com", 
      "signature"=>"baeab82254bfecd9ad8a827dab1bbc32", 
      "subject"=>"Test Tracking Message", 
      "to"=>"<41ce8c7a7c6bf8c27fcc@cloudmailin.net>", 
      "message"=>"Received: by iyi42 with SMTP id 42so3703677iyi.3\r\n        for <41ce8c7a7c6bf8c27fcc@cloudmailin.net>; Sat, 15 Jan 2011 15:36:00 -0800 (PST)\r\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;\r\n        d=gmail.com; s=gamma;\r\n        h=domainkey-signature:mime-version:from:date:message-id:subject:to\r\n         :content-type;\r\n        bh=IiqeMyXQ8xwrW/c8Sy5WrX2W/7/kGhmL0r+vbWXwjCs=;\r\n        b=QUJmnuB8Hb2kqex7KJ8HQwI770CT+XQ20ypGyozuRaI6Ptgs8UTSTqWb6wKGCQv79c\r\n         hq8hIVEbgP/cHQe+gIUvlRHHi9OQq6oes8uq5OU6DcK4x460dS0Kjhmt5u6p9LV5AHPr\r\n         P8Z8E/GsQPzuImmr9U77YiWw2fHF0WcXTb1rI=\r\nDomainKey-Signature: a=rsa-sha1; c=nofws;\r\n        d=gmail.com; s=gamma;\r\n        h=mime-version:from:date:message-id:subject:to:content-type;\r\n        b=IUsVJoaEQEWETLGy9DYks0m7JLILcPqKsHzfLGI/+ZW7gJXJkyh/9lMWo5Y/Ju1w/p\r\n         cATIDImQPTA1qIbHA9CCG0+v+lzrsttBg0wXn9ICJ9T5A/KpTJ8e4myql51pXIzdFT2j\r\n         Q2CcYv91bSX13VhYISryQyrfp2VoYa+P9aVcY=\r\nReceived: by 10.231.19.77 with SMTP id z13mr2370086iba.166.1295134560827; Sat,\r\n 15 Jan 2011 15:36:00 -0800 (PST)\r\nMIME-Version: 1.0\r\nReceived: by 10.231.17.3 with HTTP; Sat, 15 Jan 2011 15:35:40 -0800 (PST)\r\nFrom: Jeff Keen <jeffxl@gmail.com>\r\nDate: Sat, 15 Jan 2011 17:35:40 -0600\r\nMessage-ID: <AANLkTikmwGHJLNe9gmE10tsMLJk0zOEm1vmWSA2_6oc9@mail.gmail.com>\r\nSubject: Test Tracking Message\r\nTo: 41ce8c7a7c6bf8c27fcc@cloudmailin.net\r\nContent-Type: multipart/alternative; boundary=00221532cba86f3e280499eb0335\r\n\r\n--00221532cba86f3e280499eb0335\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\nAmazon.com items (Sold by Amazon.com, LLC) :\r\n\r\n  1  General Tools IRT206 Infar...   $46.62               1   $46.62\r\n\r\nShipped via UPS\r\n\r\nTracking number: 1Z5R89390262095290\r\n\r\n--------------------------------------------------------------------\r\n                         Item Subtotal:     $46.62\r\n                Shipping  and handling:      $0.00\r\n                                 Total:     $46.62\r\n                          Paid by Visa:     $46.62\r\n--------------------------------------------------------------------\r\n\r\n--00221532cba86f3e280499eb0335\r\nContent-Type: text/html; charset=ISO-8859-1\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<span class=3D\"Apple-style-span\" style=3D\"font-family: arial, sans-serif; f=\r\nont-size: 13px; border-collapse: collapse; \">Amazon.com items (Sold by Amaz=\r\non.com, LLC) :<br><br>=A0 1 =A0General Tools IRT206 Infar... =A0 $46.62 =A0=\r\n =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 $46.62<br>\r\n\r\n<br>Shipped via UPS<br><br><span class=3D\"il\" style=3D\"background-image: in=\r\nitial; background-attachment: initial; background-origin: initial; backgrou=\r\nnd-clip: initial; background-color: rgb(255, 255, 204); color: rgb(34, 34, =\r\n34); background-position: initial initial; background-repeat: initial initi=\r\nal; \">Tracking</span>=A0<span class=3D\"il\" style=3D\"background-image: initi=\r\nal; background-attachment: initial; background-origin: initial; background-=\r\nclip: initial; background-color: rgb(255, 255, 204); color: rgb(34, 34, 34)=\r\n; background-position: initial initial; background-repeat: initial initial;=\r\n \">number</span>: 1Z5R89390262095290<br>\r\n\r\n<br>--------------------------------------------------------------------<br=\r\n>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Item Subtotal: =A0 =A0 =\r\n$46.62<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Shipping =A0and handling: =A0 =A0=\r\n =A0$0.00<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =\r\n=A0 =A0Total: =A0 =A0 $46.62<br>\r\n\r\n=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Paid by Visa: =A0 =A0 $=\r\n46.62<br>------------------------------------------------------------------=\r\n--</span>\r\n\r\n--00221532cba86f3e280499eb0335--"}
    
  end
  
end
