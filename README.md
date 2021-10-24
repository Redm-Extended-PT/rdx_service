# rdx_service

## Download & Installation

- Download https://github.com/Redm-Extended-PT/rdx_service
- Put it in the `[rdx]` directory

## Installation
- Add this to your `server.cfg`:

```
ensure rdx_service
```

## Usage
```lua
-- Enable service
ESX.TriggerServerCallback('rdx_service:enableService', function(canTakeService, maxInService, inServiceCount)

  if canTakeService then
    ESX.ShowNotification('You enabled service')
  else
    ESX.ShowNotification('Service is full: ' .. inServiceCount .. '/' .. maxInService)
  end

end, 'taxi')

-- Disable service
TriggerServerEvent('rdx_service:disableService', 'taxi')
```