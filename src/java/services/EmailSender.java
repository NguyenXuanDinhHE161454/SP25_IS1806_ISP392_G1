package services;

import java.util.List;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailSender {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_SENDER = "vnpaysp2k2@gmail.com"; // Thay bằng email của bạn
    private static final String EMAIL_PASSWORD = "layr rotv eces pxkr"; // Thay bằng mật khẩu ứng dụng

    public static void sendEmail(String recipientEmail, String subject, String body, boolean isHtml) {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_SENDER, EMAIL_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_SENDER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            if (isHtml) {
                message.setContent(body, "text/html; charset=utf-8");
            } else {
                message.setText(body);
            }
            Transport.send(message);
            System.out.println("Email sent successfully to " + recipientEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public static String getResetPasswordTemplate(String otp) {
        return "<html><body>"
                + "<h2>Reset Your Password</h2>"
                + "<p>Your OTP code is: <strong>" + otp + "</strong></p>"
                + "<p>Please enter this code to reset your password.</p>"
                + "</body></html>";
    }

    public static String getWelcomeTemplate(String name) {
        return "<html><body>"
                + "<h2>Welcome, " + name + "!</h2>"
                + "<p>Thank you for signing up. We are excited to have you on board.</p>"
                + "</body></html>";
    }

    public static String getOrderConfirmationTemplate(String orderId, List<String> productNames, List<Double> prices) {
        StringBuilder productListHtml = new StringBuilder();
        double total = 0;
        for (int i = 0; i < productNames.size(); i++) {
            productListHtml.append("<tr><td>").append(productNames.get(i)).append("</td><td>")
                    .append(prices.get(i)).append(" USD</td></tr>");
            total += prices.get(i);
        }
        return "<html><body>"
                + "<h2>Order Confirmation</h2>"
                + "<p>Thank you for your purchase!</p>"
                + "<p>Order ID: <strong>" + orderId + "</strong></p>"
                + "<table border='1' cellpadding='5' cellspacing='0'>"
                + "<tr><th>Product</th><th>Price</th></tr>"
                + productListHtml
                + "<tr><td><strong>Total</strong></td><td><strong>" + total + " USD</strong></td></tr>"
                + "</table>"
                + "<p>We will notify you once your order is shipped.</p>"
                + "</body></html>";
    }

    public static String getInvoiceTemplate(String invoiceId, String customerName, List<String> items, List<Double> prices) {
        StringBuilder itemsHtml = new StringBuilder();
        double total = 0;
        for (int i = 0; i < items.size(); i++) {
            itemsHtml.append("<tr><td>").append(items.get(i)).append("</td><td>")
                    .append(prices.get(i)).append(" USD</td></tr>");
            total += prices.get(i);
        }
        return "<html><body>"
                + "<h2>Invoice #" + invoiceId + "</h2>"
                + "<p>Customer: <strong>" + customerName + "</strong></p>"
                + "<table border='1' cellpadding='5' cellspacing='0'>"
                + "<tr><th>Item</th><th>Price</th></tr>"
                + itemsHtml
                + "<tr><td><strong>Total</strong></td><td><strong>" + total + " USD</strong></td></tr>"
                + "</table>"
                + "<p>Thank you for your business!</p>"
                + "</body></html>";
    }

    public static String getShippingNotificationTemplate(String trackingNumber, String carrier) {
        return "<html><body>"
                + "<h2>Shipping Notification</h2>"
                + "<p>Your order has been shipped!</p>"
                + "<p>Tracking Number: <strong>" + trackingNumber + "</strong></p>"
                + "<p>Carrier: <strong>" + carrier + "</strong></p>"
                + "<p>Click <a href='https://www." + carrier.toLowerCase() + ".com/track?num=" + trackingNumber + "'>here</a> to track your order.</p>"
                + "</body></html>";
    }

    public static String getSubscriptionRenewalTemplate(String planName, String renewalDate, double price) {
        return "<html><body>"
                + "<h2>Subscription Renewal Reminder</h2>"
                + "<p>Your <strong>" + planName + "</strong> subscription will renew on <strong>" + renewalDate + "</strong>.</p>"
                + "<p>Renewal Price: <strong>" + price + " USD</strong></p>"
                + "<p>If you wish to cancel, please do so before the renewal date.</p>"
                + "</body></html>";
    }

    public static void main(String[] args) {
//        sendEmail("tung020802@gmail.com", "Reset Password OTP", getResetPasswordTemplate("123456"), true);
//
//        sendEmail("tung020802@gmail.com", "Welcome to Our Service", getWelcomeTemplate("John Doe"), true);
//
//        sendEmail("tung020802@gmail.com", "Order Confirmation",
//                getOrderConfirmationTemplate("ORD12345", List.of("Smartphone XYZ", "Wireless Headphones"), List.of(699.99, 149.99)), true);
//
//        sendEmail("tung020802@gmail.com", "Invoice #INV98765",
//                getInvoiceTemplate("INV98765", "Jane Doe", List.of("Laptop", "Mouse", "Keyboard"), List.of(999.99, 49.99, 79.99)), true);
//
//        sendEmail("tung020802@gmail.com", "Shipping Notification",
//                getShippingNotificationTemplate("1Z9999999999999999", "UPS"), true);
//
//        sendEmail("tung020802@gmail.com", "Subscription Renewal Reminder",
//                getSubscriptionRenewalTemplate("Premium Plan", "2025-04-01", 19.99), true);

    }
}
