<?php

/**
 * The public-facing functionality of the plugin.
 *
 * @since      1.0
 *
 * @package    Kam
 * @subpackage Kam/includes
 */

/**
 * The public-facing functionality of the plugin.
 *
 * Defines the plugin name, version, and two examples hooks for how to
 * enqueue the dashboard-specific stylesheet and JavaScript.
 *
 * @package    Kam
 * @subpackage Kam/admin
 * @author     Your Name <email@example.com>
 */
class Kam_Public {
	/**
	 * The ID of this plugin.
	 *
	 * @since    1.0
	 * @access   private
	 * @var      string    $name    The ID of this plugin.
	 */
	private $name;

	/**
	 * The version of this plugin.
	 *
	 * @since    1.0
	 * @access   private
	 * @var      string    $version    The current version of this plugin.
	 */
	private $version;

	/**
	 * Initialize the class and set its properties.
	 *
	 * @since    1.0
	 * @var      string    $name       The name of the plugin.
	 * @var      string    $version    The version of this plugin.
	 */
	public function __construct( $name, $version ) {
		$this->name = $name;
		$this->version = $version;
	}

	/**
	 * Register the stylesheets for the public-facing side of the site.
	 *
	 * @since    1.0
	 */
	public function enqueue_styles() {
		wp_enqueue_style( $this->name, plugin_dir_url( __FILE__ ) . 'css/kam-public.css', array(), $this->version, 'all' );
	}

	/**
	 * Register the stylesheets for the public-facing side of the site.
	 *
	 * @since    1.0
	 */
	public function enqueue_scripts() {
		wp_enqueue_script( $this->name, plugin_dir_url( __FILE__ ) . 'js/kam-public.js', array( 'jquery' ), $this->version, FALSE );
	}
}
