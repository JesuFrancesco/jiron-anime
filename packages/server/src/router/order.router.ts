import { sb } from "../app";
import { OrderRouter } from "../generated/express/Order";
import { authHandler } from "../middleware/authorization.handler";
import { OrderService } from "../service/order.service";
import { commonRouterConfig } from "./const";

const orderRouter = OrderRouter(commonRouterConfig);

orderRouter.post("/order/procesar-pago", authHandler, async (req, res) => {
  const service = new OrderService();

  const { data } = req.body;

  const {
    data: {
      user: { user_metadata },
    },
  } = await sb.auth.getUser();

  const clientId = user_metadata["client_id"];
  const ShoppingCartId = user_metadata["cart_id"];

  const createdOrder = await service.procesarPago(
    clientId,
    ShoppingCartId,
    data
  );

  return res.status(201).json(createdOrder);
});

orderRouter.post("/order/confirmar-orden", authHandler, async (req, res, next) => {
  try {
    const service = new OrderService();

    const { id: orderId } = req.body;

    if (!orderId) {
      return res.status(400).json({ message: "Order ID no enviado" });
    }

    const completedOrder = await service.completarOrden(orderId);

    return res.status(200).json(completedOrder);
  } catch (error) {
    next(error);
  }
});


export default orderRouter;
