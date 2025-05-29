package websocket;

import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import jakarta.websocket.*;

import java.util.*;


@ServerEndpoint("/cartSync/{idUser}")
public class CartSyncEndpoint {
    private static Map<Integer, Session> userSessions = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("idUser") int idUser) {
        userSessions.put(idUser, session);
        System.out.println("WebSocket connected: idUser = " + idUser);
    }

    @OnClose
    public void onClose(Session session, @PathParam("idUser") int idUser) {
        userSessions.remove(idUser);
        System.out.println("WebSocket disconnected: userId = " + idUser);
    }

    public static void notifyCartChanged(int userId) {
        Session session = userSessions.get(userId);
        if (session != null && session.isOpen()) {
            try {
                session.getBasicRemote().sendText("refresh");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
