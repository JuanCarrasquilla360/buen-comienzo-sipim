using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace BuenComienzo.SignalR
{
    public class MIASSignalRHub: Microsoft.AspNet.SignalR.Hub
    {
        public void Send(string name, string message)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(name, message);
        }
        public void registerUserToGroup(string groupName)
        {
            Groups.Add(Context.ConnectionId, groupName);
            Clients.Client(Context.ConnectionId).groupJoinedSuccess();
        }
        
        public void sendNotificationsToGroup(string groupName,string message)
        {
            Clients.Group(groupName).receiveNotification(message);
        }
    }
}