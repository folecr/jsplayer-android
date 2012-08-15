package com.cocosspidermonkey;

import java.io.File;

public class CocosApp {
    public String name;

    public String toString() {
        return name;
    }

    public static class ExternalApp extends CocosApp {
        public File root;

        public ExternalApp (File f) {
            name = f.getName();
            root = f.getAbsoluteFile();
        }
    }
}
