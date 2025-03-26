package utils;

import com.google.gson.JsonObject;
import java.lang.reflect.Field;
import java.util.Map;

public class JsonUtils {

    public static String objectToJson(Object obj) {
        if (obj == null) {
            return "{}";
        }
        JsonObject jsonObject = new JsonObject();
        for (Field field : obj.getClass().getDeclaredFields()) {
            field.setAccessible(true);
            try {
                Object value = field.get(obj);
                addValueToJson(jsonObject, field.getName(), value);
            } catch (IllegalAccessException ignored) {
            }
        }
        return jsonObject.toString();
    }

    public static JsonObject mapToJson(Map<String, Object> map) {
        JsonObject jsonObject = new JsonObject();
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            addValueToJson(jsonObject, entry.getKey(), entry.getValue());
        }
        return jsonObject;
    }

    private static void addValueToJson(JsonObject jsonObject, String key, Object value) {
        if (value instanceof String) {
            jsonObject.addProperty(key, (String) value);
        } else if (value instanceof Number) {
            jsonObject.addProperty(key, (Number) value);
        } else if (value instanceof Boolean) {
            jsonObject.addProperty(key, (Boolean) value);
        } else if (value != null) {
            jsonObject.addProperty(key, value.toString());
        }
    }

    public static boolean isValidJson(String json) {
        try {
            new com.google.gson.JsonParser().parse(json).getAsJsonObject();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
