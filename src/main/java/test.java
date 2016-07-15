import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Hashtable;

public class test {
    public static void main(String[] args) throws BadHanyuPinyinOutputFormatCombination, WriterException, IOException {

//        HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
//        format.setCaseType(HanyuPinyinCaseType.LOWERCASE);
//        format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
//        format.setVCharType(HanyuPinyinVCharType.WITH_V);
//
//        String pingyin = PinyinHelper.toHanYuPinyinString("绿色",format,"",true);
//        System.out.println(pingyin);
        String mecard = "MECARD:N:范范;ORG:中标软件;TEL:13167067992;EMAIL:fanfan@126.com;ADR:中国;;";

        Hashtable hints = new Hashtable();

        hints.put(EncodeHintType.CHARACTER_SET,"UTF-8");

        BitMatrix bitMatrix = new MultiFormatWriter().encode(mecard, BarcodeFormat.QR_CODE,400,400,hints);

        MatrixToImageWriter.writeToStream(bitMatrix,"png",new FileOutputStream("D:/qr.png"));



    }
}
