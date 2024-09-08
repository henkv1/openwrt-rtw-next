#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/elfnote-lto.h>
#include <linux/export-internal.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

#ifdef CONFIG_UNWINDER_ORC
#include <asm/orc_header.h>
ORC_HEADER;
#endif

BUILD_SALT;
BUILD_LTO_INFO;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_MITIGATION_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

KSYMTAB_DATA(rtw_disable_lps_deep_mode, "", "");
KSYMTAB_DATA(rtw_debug_mask, "", "");
KSYMTAB_FUNC(rtw_dump_fw, "", "");
KSYMTAB_FUNC(rtw_dump_reg, "", "");
KSYMTAB_FUNC(rtw_set_rx_freq_band, "", "");
KSYMTAB_FUNC(rtw_chip_info_setup, "", "");
KSYMTAB_FUNC(rtw_core_init, "", "");
KSYMTAB_FUNC(rtw_core_deinit, "", "");
KSYMTAB_FUNC(rtw_register_hw, "", "");
KSYMTAB_FUNC(rtw_unregister_hw, "", "");
KSYMTAB_DATA(rtw_ops, "", "");
KSYMTAB_FUNC(check_hw_ready, "", "");
KSYMTAB_FUNC(rtw_restore_reg, "", "");
KSYMTAB_FUNC(rtw_tx_fill_tx_desc, "", "");
KSYMTAB_FUNC(rtw_tx_report_enqueue, "", "");
KSYMTAB_FUNC(rtw_tx_write_data_rsvd_page_get, "", "");
KSYMTAB_FUNC(rtw_tx_write_data_h2c_get, "", "");
KSYMTAB_FUNC(rtw_tx_ac_to_hwq, "", "");
KSYMTAB_FUNC(rtw_tx_queue_mapping, "", "");
KSYMTAB_FUNC(rtw_rx_stats, "", "");
KSYMTAB_FUNC(rtw_update_rx_freq_from_ie, "", "");
KSYMTAB_FUNC(rtw_rx_fill_rx_status, "", "");
KSYMTAB_FUNC(rtw_set_channel_mac, "", "");
KSYMTAB_DATA(rtw_rate_section, "", "");
KSYMTAB_DATA(rtw_rate_size, "", "");
KSYMTAB_FUNC(rtw_phy_set_edcca_th, "", "");
KSYMTAB_FUNC(rtw_phy_init, "", "");
KSYMTAB_FUNC(rtw_phy_parsing_cfo, "", "");
KSYMTAB_FUNC(rtw_phy_rf_power_2_rssi, "", "");
KSYMTAB_FUNC(rtw_phy_read_rf, "", "");
KSYMTAB_FUNC(rtw_phy_read_rf_sipi, "", "");
KSYMTAB_FUNC(rtw_phy_write_rf_reg_sipi, "", "");
KSYMTAB_FUNC(rtw_phy_write_rf_reg_mix, "", "");
KSYMTAB_FUNC(rtw_parse_tbl_phy_cond, "", "");
KSYMTAB_FUNC(rtw_parse_tbl_bb_pg, "", "");
KSYMTAB_FUNC(rtw_parse_tbl_txpwr_lmt, "", "");
KSYMTAB_FUNC(rtw_phy_cfg_mac, "", "");
KSYMTAB_FUNC(rtw_phy_cfg_agc, "", "");
KSYMTAB_FUNC(rtw_phy_cfg_bb, "", "");
KSYMTAB_FUNC(rtw_phy_cfg_rf, "", "");
KSYMTAB_FUNC(rtw_phy_load_tables, "", "");
KSYMTAB_FUNC(rtw_phy_get_tx_power_index, "", "");
KSYMTAB_FUNC(rtw_phy_set_tx_power_level, "", "");
KSYMTAB_FUNC(rtw_phy_config_swing_table, "", "");
KSYMTAB_FUNC(rtw_phy_pwrtrack_avg, "", "");
KSYMTAB_FUNC(rtw_phy_pwrtrack_thermal_changed, "", "");
KSYMTAB_FUNC(rtw_phy_pwrtrack_get_delta, "", "");
KSYMTAB_FUNC(rtw_phy_pwrtrack_get_pwridx, "", "");
KSYMTAB_FUNC(rtw_phy_pwrtrack_need_lck, "", "");
KSYMTAB_FUNC(rtw_phy_pwrtrack_need_iqk, "", "");
KSYMTAB_FUNC(rtw_coex_write_scbd, "", "");
KSYMTAB_FUNC(rtw_coex_read_indirect_reg, "", "");
KSYMTAB_FUNC(rtw_coex_write_indirect_reg, "", "");
KSYMTAB_FUNC(rtw_read8_physical_efuse, "", "");
KSYMTAB_FUNC(rtw_fw_c2h_cmd_rx_irqsafe, "", "");
KSYMTAB_FUNC(rtw_fw_c2h_cmd_isr, "", "");
KSYMTAB_FUNC(rtw_fw_do_iqk, "", "");
KSYMTAB_FUNC(rtw_fw_inform_rfk_status, "", "");
KSYMTAB_FUNC(rtw_power_mode_change, "", "");
KSYMTAB_FUNC(rtw_bf_enable_bfee_su, "", "");
KSYMTAB_FUNC(rtw_bf_enable_bfee_mu, "", "");
KSYMTAB_FUNC(rtw_bf_remove_bfee_su, "", "");
KSYMTAB_FUNC(rtw_bf_remove_bfee_mu, "", "");
KSYMTAB_FUNC(rtw_bf_set_gid_table, "", "");
KSYMTAB_FUNC(rtw_bf_phy_init, "", "");
KSYMTAB_FUNC(rtw_bf_cfg_csi_rate, "", "");
KSYMTAB_FUNC(rtw_regd_get, "", "");
KSYMTAB_FUNC(rtw_regd_srrc, "", "");

MODULE_INFO(depends, "mac80211,cfg80211");

