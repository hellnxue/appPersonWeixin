package org.apache.shiro.common;

import com.google.common.collect.Maps;
import org.apache.commons.codec.binary.Hex;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.*;

/**

 * <p>Date: 14-2-26
 * <p>Version: 1.0
 */
public class HmacSHA256Utils {

    private static Comparator<Map.Entry<String, ?>> comparator = new Comparator<Map.Entry<String, ?>>() {
        @Override
        public int compare(Map.Entry<String,?> o1, Map.Entry<String, ?> o2) {
            return o1.getKey().compareTo(o2.getKey());
        }
    };

    public static String digest(String key, String content) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            byte[] secretByte = key.getBytes("utf-8");
            byte[] dataBytes = content.getBytes("utf-8");

            SecretKey secret = new SecretKeySpec(secretByte, "HMACSHA256");
            mac.init(secret);

            byte[] doFinal = mac.doFinal(dataBytes);
            byte[] hexB = new Hex().encode(doFinal);
            return new String(hexB, "utf-8");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String digest(String key, Map<String, Object> map) {
        //sort map for device
        map = sortMap(map);
        StringBuilder s = new StringBuilder();
        for(Object values : map.values()) {
            if(values instanceof String[]) {
                for(String value : (String[])values) {
                    s.append(value);
                }
            } else if(values instanceof List) {
                for(String value : (List<String>)values) {
                    s.append(value);
                }
            } else {
                s.append(values);
            }
        }
        return digest(key, s.toString());
    }

    private static Map<String, Object> sortMap(Map<String, Object> map) {
        List<Map.Entry<String,?>> list = new ArrayList<Map.Entry<String, ?>>(map.entrySet());
        Collections.sort(list, comparator);
        map = Maps.newLinkedHashMap();
        for (Map.Entry<String, ?> entry : list) {
           map.put(entry.getKey(),entry.getValue());
        }
        return map;
    }

}
