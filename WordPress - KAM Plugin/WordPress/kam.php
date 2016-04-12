<?php

/**
 * The plugin bootstrap file
 *
 * This file is read by WordPress to generate the plugin information in the plugin
 * Dashboard. This file also includes all of the dependencies used by the plugin,
 * registers the activation and deactivation functions, and defines a function
 * this starts the plugin.
 *
 * @link              http://example.com
 * @since             1.0.0
 * @package           Kam
 *
 * @wordpress-plugin
 * Plugin Name:       Kids Activity Marketplace
 * Plugin URI:        http://example.com/kam-uri/
 * Description:       This is a short description of what the plugin does. It's displayed in the WordPress dashboard.
 * Version:           1.0
 * Author:            Your Name or Your Company
 * Author URI:        http://example.com/
 * License:           GPL-2.0+
 * License URI:       http://www.gnu.org/licenses/gpl-2.0.txt
 * Text Domain:       kam
 * Domain Path:       /languages
 */

// If this file is called directly, abort.
if ( ! defined( 'WPINC' ) ) {
	die;
}

/**
 * The code that runs during plugin activation.
 */
function activate_plugin_name() {
require_once plugin_dir_path( __FILE__ ) . 'includes/class-kam-activator.php';
Kam_Activator::activate();
}
/**
 * The code that runs during plugin deactivation.
 */
function deactivate_plugin_name() {
require_once plugin_dir_path( __FILE__ ) . 'includes/class-kam-deactivator.php';
Kam_Deactivator::deactivate();
}
register_activation_hook( __FILE__, 'activate_plugin_name' );
register_deactivation_hook( __FILE__, 'deactivate_plugin_name' );
/** This action is documented in includes/class-kam-activator.php */
//register_activation_hook( __FILE__, array( 'Kam_Activator', 'activate' ) );

/** This action is documented in includes/class-kam-deactivator.php */
//register_activation_hook( __FILE__, array( 'Kam_Deactivator', 'deactivate' ) );

/**
 * The core plugin class that is used to define internationalization,
 * dashboard-specific hooks, and public-facing site hooks.
 */
require_once plugin_dir_path( __FILE__ ) . 'includes/class-kam.php';

/**
 * Begins execution of the plugin.
 *
 * Since everything within the plugin is registered via hooks,
 * then kicking off the plugin from this point in the file does
 * not affect the page life cycle.
 *
 * @since    1.0.0
 */
function run_Kam() {

	$plugin = new Kam();
	$plugin->run();

}
run_Kam();
  