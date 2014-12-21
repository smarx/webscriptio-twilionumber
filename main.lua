-- get available numbers in an area code
local getNumbers = function(twilioSid, twilioToken, areaCode)

  local response = http.request {
    url = string.format('https://api.twilio.com/2010-04-01/Accounts/%s/AvailablePhoneNumbers/US/Local.json', twilioSid),
    auth = { twilioSid, twilioToken },
    params = {
      AreaCode=areaCode,
      ExcludeAllAddressRequired=false,
      ExcludeLocalAddressRequired=false,
      ExcludeForeignAddressRequired=false
    }
  }

  return json.parse(response.content)

end

-- buy an available number in an area code
-- returns nil if no phone number can be purchased
local buyNumber = function(twilioSid, twilioToken, areaCode)

  local response = http.request {
    method = 'POST',
    url = string.format('https://api.twilio.com/2010-04-01/Accounts/%s/IncomingPhoneNumbers.json', twilioSid),
    auth = { twilioSid, twilioToken },
    data = { AreaCode = areaCode }
  }

  if response.statuscode == 200 then
    return json.parse(response.content)
  else
    return nil
  end

end

return {
  getNumbers = getNumbers,
  buyNumber = buyNumber
}
