#include <jni.h>
#include <dlfcn.h>
#include <android/log.h>
#include <filesystem>
#include <string>
#include <thread>

#define LOG_TAG "NexusSDK_Core"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

namespace fs = std::filesystem;

// Funkcja odpowiedzialna za skanowanie i ładowanie modów
void uruchom_nexus_loader() {
    LOGI("[NexusSDK] Inicjalizacja loadera...");

    // Ścieżka do folderu z modami w pamięci prywatnej aplikacji na Androidzie
    std::string sciezka_modow = "/data/data/com.robtopx.geometryjump/nexus_mods/";

    try {
        // Jeśli folder nie istnieje, NexusSDK sam go stworzy
        if (!fs::exists(sciezka_modow)) {
            fs::create_directories(sciezka_modow);
            LOGI("[NexusSDK] Stworzono nowy folder na mody: %s", sciezka_modow.c_str());
        }

        LOGI("[NexusSDK] Skanowanie folderu w poszukiwaniu modów (.so)...");

        // Przeszukujemy folder plik po pliku
        for (const auto& entry : fs::directory_iterator(sciezka_modow)) {
            if (entry.is_regular_file() && entry.path().extension() == ".so") {
                std::string sciezka_pliku = entry.path().string();
                LOGI("[NexusSDK] Znaleziono mod: %s. Próba załadowania...", sciezka_pliku.c_str());

                // NAJWAŻNIEJSZY MOMENT: Wstrzyknięcie moda do pamięci gry
                void* handle = dlopen(sciezka_pliku.c_str(), RTLD_NOW);

                if (handle) {
                    LOGI("[NexusSDK] Sukces! Mod %s został pomyślnie wstrzyknięty.", entry.path().filename().c_str());
                } else {
                    LOGE("[NexusSDK] Błąd ładowania moda %s: %s", entry.path().filename().c_str(), dlerror());
                }
            }
        }
    } catch (const std::exception& e) {
        LOGE("[NexusSDK] Krytyczny błąd systemu plików: %s", e.what());
    }

    LOGI("[NexusSDK] Skanowanie zakończone. NexusSDK działa w tle.");
}

// Główny punkt wejścia wywoływany przez Androida przy starcie Geometry Dash
jint JNI_OnLoad(JavaVM* vm, void* reserved) {
    JNIEnv* env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
        return JNI_ERR;
    }

    // Odpalamy loader w osobnym wątku systemowym, żeby gra się nie zawiesiła podczas włączania
    std::thread(uruchom_nexus_loader).detach();

    return JNI_VERSION_1_6;
}
